package com.mjtech.fintesthub.flutter.fintesthub_flutter.payment

data class MSitefPayment(
    val id: Long,
    val amount: Double,
    val type: String,
    val installments: Int,
    val installmentType: String,
    val empresaSitef: String,
    val enderecoSitef: String,
    val operador: String,
    val cnpjCpf: String,
    val cnpjAutomacao: String
) {
    companion object {
        fun fromMap(map: Map<String, Any?>): MSitefPayment {
            return MSitefPayment(
                id = (map["id"] as? Number)?.toLong() ?: 0L,

                amount = (map["amount"] as? Number)?.toDouble() ?: 0.0,

                type = map["type"] as? String ?: "debit",

                installments = (map["installments"] as? Number)?.toInt() ?: 1,

                installmentType = map["installmentType"] as? String ?: "none",

                empresaSitef = map["empresaSitef"] as? String ?: "",

                enderecoSitef = map["enderecoSitef"] as? String ?: "",

                operador = map["operador"] as? String ?: "",

                cnpjCpf = map["cnpjCpf"] as? String ?: "",

                cnpjAutomacao = map["cnpjAutomacao"] as? String ?: ""
            )
        }
    }
}
