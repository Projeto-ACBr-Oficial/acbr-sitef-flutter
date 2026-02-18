package com.mjtech.fintesthub.flutter.fintesthub_flutter.payment

data class MSitefPayment(
    val id: Long,
    val amount: Double,
    val type: String,
    val installments: Int,
    val installmentType: String,
    val timestamp: Long
) {
    companion object {
        fun fromMap(map: Map<String, Any?>): MSitefPayment {
            return MSitefPayment(
                id = (map["id"] as? Number)?.toLong() ?: 0L,

                amount = (map["amount"] as? Number)?.toDouble() ?: 0.0,

                type = map["type"] as? String ?: "debit",

                installments = (map["installments"] as? Number)?.toInt() ?: 1,

                installmentType = map["installmentType"] as? String ?: "none",

                timestamp = (map["timestamp"] as? Number)?.toLong() ?: 0L
            )
        }
    }
}
