package com.mjtech.fintesthub.flutter.fintesthub_flutter

import android.app.Activity
import android.content.Intent
import com.mjtech.fintesthub.flutter.fintesthub_flutter.admin.MSitefAdmin
import com.mjtech.fintesthub.flutter.fintesthub_flutter.common.MSitefResponse
import com.mjtech.fintesthub.flutter.fintesthub_flutter.payment.MSitefPayment
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
    private val FISERV_ADMIN_REQUEST_CODE = 1002
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "pay") {
                if (pendingResult != null) {
                    result.error("BUSY", "Já existe uma solicitação em andamento", null)
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
            } else if (call.method == "admin") {
                if (pendingResult != null) {
                    result.error("BUSY", "Já existe uma solicitação em andamento", null)
                    return@setMethodCallHandler
                }

                val argsMap = call.arguments as? Map<String, Any?>
                if (argsMap != null) {
                    val adminArgs = MSitefAdmin.fromMap(argsMap)

                    pendingResult = result
                    startAdminMenuMsitef(adminArgs)
                } else {
                    result.error("INVALID_ARGS", "Argumentos inválidos", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    /**
     * Inicia o processo de pagamento via SiTef Msitef, construindo a Intent com os parâmetros necessários
     * e tratando o resultado na função onActivityResult para retornar o status da transação ao Flutter.
     *
     * Utiliza os métodos auxiliares para mapear os tipos de pagamento e restrições,
     * além de formatar o valor corretamente.
     */
    private fun startPaymentMsitef(payment: MSitefPayment) {
        val modalidade = mapPaymentMethod(payment.type)
        val valor = payment.amount.toStringWithoutDots()
        val restricoes = mapRestriction(payment.type, payment.installments)

        val fiservIntent = Intent("br.com.softwareexpress.sitef.msitef.ACTIVITY_CLISITEF").apply {

            // Parâmetros de entrada para o SiTef
            putExtra("empresaSitef", payment.empresaSitef)
            putExtra("enderecoSitef", payment.enderecoSitef.getFullAddress())
            putExtra("operador", payment.operador)
            putExtra("CNPJ_CPF", payment.cnpjCpf)
            putExtra("cnpj_automacao", payment.cnpjAutomacao)

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

    /**
     * Inicia o menu administrativo do SiTef Msitef, construindo a Intent com os parâmetros necessários
     * e tratando o resultado na função onActivityResult para retornar o status da operação administrativa ao Flutter.
     */
    private fun startAdminMenuMsitef(admin: MSitefAdmin) {
        val modalidade = "110" // Menu Administrativo
        val valor = "0"
        val restricoes = "TransacoesAdicionaisHabilitadas=8;3919"

        val intent = Intent("br.com.softwareexpress.sitef.msitef.ACTIVITY_CLISITEF").apply {

            // Parâmetros de entrada para o SiTef
            putExtra("empresaSitef", admin.empresaSitef)
            putExtra("enderecoSitef", admin.enderecoSitef.getFullAddress())
            putExtra("operador", admin.operador)
            putExtra("CNPJ_CPF", admin.cnpjCpf)
            putExtra("cnpj_automacao", admin.cnpjAutomacao)

            // Configurações para o menu administrativo
            putExtra("modalidade", modalidade)
            putExtra("valor", valor)
            putExtra("restricoes", restricoes)
        }

        try {
            startActivityForResult(intent, FISERV_ADMIN_REQUEST_CODE)
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

        val response = MSitefResponse(data)

        if (requestCode == FISERV_PAYMENT_REQUEST_CODE) {
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
        } else if (requestCode == FISERV_ADMIN_REQUEST_CODE) {
            val adminMap = HashMap<String, String>()

            when (resultCode) {
                Activity.RESULT_OK -> {
                    adminMap["status"] = "SUCCESS"
                    adminMap["action"] = "admin_success"
                    adminMap["receipt"] = response.viaCliente ?: "Operação concluída"
                }
                Activity.RESULT_CANCELED -> {
                    adminMap["status"] = "FAILURE"
                    adminMap["action"] = "admin_cancelled"
                    adminMap["errorMessage"] = "Operação cancelada"
                }
                else -> {
                    adminMap["status"] = "FAILURE"
                    adminMap["errorMessage"] = "Erro desconhecido: $resultCode"
                }
            }

            pendingResult?.success(adminMap)
            pendingResult = null
        }
    }
}
