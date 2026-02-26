package com.mjtech.fintesthub.flutter.fintesthub_flutter.admin

data class MSitefAdmin(
    val empresaSitef: String,
    val enderecoSitef: String,
    val operador: String,
    val cnpjCpf: String,
    val cnpjAutomacao: String
) {

    companion object {
        fun fromMap(map: Map<String, Any?>): MSitefAdmin {
            return MSitefAdmin(
                empresaSitef = map["empresaSitef"] as? String ?: "",
                enderecoSitef = map["enderecoSitef"] as? String ?: "",
                operador = map["operador"] as? String ?: "",
                cnpjCpf = map["cnpjCpf"] as? String ?: "",
                cnpjAutomacao = map["cnpjAutomacao"] as? String ?: ""
            )
        }
    }
}