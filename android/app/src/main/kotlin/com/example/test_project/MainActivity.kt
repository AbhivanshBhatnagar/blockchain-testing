package com.example.test_project

import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val channel = "avexmobile.page.link/drive_android"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "change_activity") {
//

                result.success(null)
//                } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null)
//                }
            } else {
                result.notImplemented()
            }
        }
    }

}
