package com.mjtech.fintesthub.flutter.fintesthub_flutter

import android.app.Activity
import android.content.Intent
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.MSitefPayment
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.MSitefResponse
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.getCurrentDate
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.getCurrentTime
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.getFullAddress
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.mapPaymentMethod
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.mapRestriction
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.toStringWithoutDots
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.mjtech.fintesthub.flutter/msitef"
    private val FISERV_PAYMENT_REQUEST_CODE = 1001
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "pay") {
                if (pendingResult != null) {
                    result.error("BUSY", "Já existe uma transação em andamento", null)
                    return@setMethodCallHandler
                }

                val argsMap = call.arguments as? Map<String, Any?>
                if (argsMap != null) {
                    val paymentArgs = MSitefPayment.fromMap(argsMap)

                    pendingResult = result
                    startPaymentMsitef(paymentArgs)
                } else {
                    result.error("INVALID_ARGS", "Argumentos inválidos", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startPaymentMsitef(payment: MSitefPayment) {
        val modalidade = mapPaymentMethod(payment.type)
        val valor = payment.amount.toStringWithoutDots()
        val restricoes = mapRestriction(payment.type, payment.installments)

        val fiservIntent = Intent("br.com.softwareexpress.sitef.msitef.ACTIVITY_CLISITEF").apply {

            // Parâmetros de entrada para o SiTef
            putExtra("empresaSitef", "00000000")
            putExtra("enderecoSitef", "192.168.237.24".getFullAddress())
            putExtra("operador", "0001")
            putExtra("CNPJ_CPF", "18760540000139")
            putExtra("cnpj_automacao", "18760540000139")

            // Dados da transação
            putExtra("data", getCurrentDate())
            putExtra("hora", getCurrentTime())
            putExtra("numeroCupom", getCurrentDate() + getCurrentTime())

            putExtra("valor", valor)
            putExtra("modalidade", modalidade)

            // Verifica se há parcelamento
            if (payment.installments > 1) {
                putExtra("numParcelas", payment.installments.toString())
            }

            putExtra("restricoes", restricoes)

            // Configurações adicionais
            putExtra("timeoutColeta", "60")
            putExtra("comExterna", "0")
        }

        try {
            startActivityForResult(fiservIntent, FISERV_PAYMENT_REQUEST_CODE)
        } catch (e: Exception) {
            pendingResult?.error(
                "APP_NOT_FOUND",
                "App de pagamento não encontrado: ${e.message}",
                null
            )
            pendingResult = null
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == FISERV_PAYMENT_REQUEST_CODE) {

            val response = MSitefResponse(data)

            when (resultCode) {
                Activity.RESULT_OK -> {
                    if (response.codResp == "0") {
                        val successMap = mapOf(
                            "status" to "SUCCESS",
                            "id" to (response.nsuHost ?: "00000"),
                            "message" to (response.viaEstabelecimento ?: "Aprovado")
                        )
                        pendingResult?.success(successMap)
                    } else {
                        val errorMap = mapOf(
                            "status" to "FAILURE",
                            "errorCode" to (response.codResp ?: "1"),
                            "errorMessage" to "Erro no processamento"
                        )
                        pendingResult?.success(errorMap)
                    }
                }

                Activity.RESULT_CANCELED -> {
                    val cancelMap = mapOf(
                        "status" to "CANCELLED",
                        "message" to "Operação cancelada pelo usuário ou sistema"
                    )
                    pendingResult?.success(cancelMap)
                }
            }
            pendingResult = null
        }
    }
}
