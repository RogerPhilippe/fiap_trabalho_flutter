package com.example.fiap_trabalho_flutter.logs

import android.util.Log

fun logInfo(infoMsg: String?) {
    Log.i("[INFO] ", infoMsg ?: "UNKNOWN")
}

fun logError(errorMsg: String?) {
    Log.e("[ERROR] ", errorMsg ?: "UNKNOWN")
}