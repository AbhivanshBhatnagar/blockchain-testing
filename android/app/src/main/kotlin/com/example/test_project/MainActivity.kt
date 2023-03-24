package com.example.test_project

import android.content.Intent
import com.example.test_project.GDriveExt.Companion.createTemporaryFile
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async

@OptIn(DelicateCoroutinesApi::class)
class MainActivity : FlutterFragmentActivity() {
    private val channel = "avexmobile.page.link/drive_android"
    private lateinit var gDrive: GDriveExt
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "signInWithGoogle" -> {
                    if (!this::gDrive.isInitialized) {
                        gDrive = GDriveExt()
                        gDrive.init(this)
                    }
                    gDrive.googleSignIN(this)
                    result.success(null);
                }

                "uploadNewKeysInGDrive" -> {
                    val content = "This is random keys..."
                    if (Firebase.auth.currentUser != null) {
                        val mDrive = gDrive.getDriveService(this)
                        GlobalScope.async(Dispatchers.IO) {
                            val newFile = (this@MainActivity).createTemporaryFile("temp", content)
                            gDrive.uploadFileToGDrive(this@MainActivity, newFile, mDrive)
                        }
                        result.success(null)
                    } else {
                        result.error(
                            ErrorCode.GOOGLE_USER_NOT_FOUND.toString(),
                            "Please Signup First",
                            null
                        )
                    }

                }

                "readFromGDrive" -> {
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (this::gDrive.isInitialized)
            gDrive.onActivityResult(
                requestCode,
                resultCode,
                data,
                this,
                object : GDriveResultCallback<FirebaseUser> {
                    override fun onSuccess(data: FirebaseUser) {
                        TODO("Not yet implemented")
                    }

                    override fun onError(errorMessage: String) {
                        TODO("Not yet implemented")
                    }

                })
    }

    private enum class ErrorCode {
        GOOGLE_USER_NOT_FOUND;

    }
}
