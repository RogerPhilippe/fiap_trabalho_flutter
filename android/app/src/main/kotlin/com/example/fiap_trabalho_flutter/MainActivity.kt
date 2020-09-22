package com.example.fiap_trabalho_flutter

import android.os.Bundle
import android.util.Log
import com.example.fiap_trabalho_flutter.logs.logError
import com.example.fiap_trabalho_flutter.logs.logInfo
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "app/logs"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        Log.i("[INFO]", "app/logs running...")

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            Log.i("[INFO]", "Method: ${call.method}")

            when(call.method) {
                "info" -> logInfo(call.argument<String>("infoMsg"))
                "error" -> logError(call.argument<String>("errorMsg"))
            }
        }

    }

}
