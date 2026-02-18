package com.mjtech.fintesthub.flutter.fintesthub_flutter.payment

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

const val DEBIT_TYPE = "debit"
const val CREDIT_TYPE = "credit"
const val PIX_TYPE = "pix"
const val VOUCHER_TYPE = "voucher"


/** Mapeia o tipo de pagamento para o código esperado pelo SiTef */
fun mapPaymentMethod(type: String): String {
    return when (type) {
        DEBIT_TYPE -> "2"
        CREDIT_TYPE -> "3"
        PIX_TYPE -> "122"
        VOUCHER_TYPE -> "2"
        else -> "0"
    }
}

/** Mapeia as restrições de transação com base no tipo de pagamento */
fun mapRestriction(type: String, installments: Int): String {
    val restrictionType = "TransacoesHabilitadas"

    val restrictionCode = when (type.lowercase()) {
        CREDIT_TYPE -> if (installments > 1) "27" else "26"
        DEBIT_TYPE -> "16"
        VOUCHER_TYPE -> "16"
        PIX_TYPE -> "7;8;3919"
        else -> "0"
    }
    return "$restrictionType=$restrictionCode"
}

/** Retorna a data atual no formato "yyyyMMdd" - padrão esperado pelo SiTef */
fun getCurrentDate(): String {
    val dateFormat = SimpleDateFormat("yyyyMMdd", Locale.getDefault())
    val date = Date()
    return dateFormat.format(date)
}

/** Retorna a hora atual no formato "HHmmss" - padrão esperado pelo SiTef */
fun getCurrentTime(): String {
    val timeFormat = SimpleDateFormat("HHmmss", Locale.getDefault())
    val date = Date()
    return timeFormat.format(date)
}

/** Converte um valor Double para String sem pontos, com duas casas decimais - padrão esperado pelo SiTef */
fun Double.toStringWithoutDots(): String {
    val valueFormat = String.format(Locale.ROOT, "%.2f", this)
    return valueFormat.replace(".", "")
}

/** Converte um endereço IP em um endereço padrão esperado pelo SiTef */
fun String.getFullAddress(): String {
    return "$this;$this:20036"
}