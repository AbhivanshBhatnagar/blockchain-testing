package com.example.test_project

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.content.ContextCompat.startActivity
import androidx.lifecycle.lifecycleScope
import com.example.test_project.GDriveExt.Companion.createTemporaryFile
import com.google.api.client.googleapis.extensions.android.gms.auth.UserRecoverableAuthIOException
import com.google.api.services.drive.Drive
import com.google.api.services.drive.model.FileList
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;

@OptIn(DelicateCoroutinesApi::class)
class MainActivity : FlutterFragmentActivity() {
    private val channel = "avexmobile.page.link/drive_android"
    private lateinit var methodChannel:MethodChannel
    private lateinit var gDrive: GDriveExt
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel=MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        )
        methodChannel.setMethodCallHandler { call, result ->
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
                    val arguments = call.arguments as List<*>;
                    val content = arguments[1].toString()
                    val fileName = arguments[0].toString()
                    if (Firebase.auth.currentUser != null) {
                        if (!this::gDrive.isInitialized) {
                            gDrive = GDriveExt()
                            gDrive.init(this)
                        }
                        val mDrive = gDrive.getDriveService(this)
                        GlobalScope.async(Dispatchers.IO) {
                            val newFile = (this@MainActivity).createTemporaryFile(fileName, content)
                            gDrive.uploadFileToGDrive(this@MainActivity, newFile, mDrive, fileName )
                        }
                        result.success(null)
                    } else {
                        result.error(
                            ErrorCode.GOOGLE_USER_NOT_FOUND.toString(), "Please Signup First", null
                        )
                    }

                }

                "readFromGDrive" -> {
                    if (!this::gDrive.isInitialized) {
                        gDrive = GDriveExt()
                        gDrive.init(this)
                    }
                    val fileName = (call.arguments as List<*>)[0].toString()
                    val mDrive = gDrive.getDriveService(this)
                    readContentsFromDrive(this, mDrive, fileName);
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (this::gDrive.isInitialized) gDrive.onActivityResult(requestCode,
            resultCode,
            data,
            this,
            object : GDriveResultCallback<FirebaseUser> {
                override fun onSuccess(data: FirebaseUser) {
                    methodChannel.invokeMethod("signInWithGoogle_success", data!!.uid.toString())
                }

                override fun onError(errorMessage: String) {
                    methodChannel.invokeMethod("signInWithGoogle_error", errorMessage)

                }

            })
    }

    fun readContentsFromDrive(context: Context, mDrive: Drive, fileName: String) {
        mDrive.let { googleDriveService ->
            lifecycleScope.launch(Dispatchers.IO) {
                try {
//                    for(int i ==0;i)
                    val result = googleDriveService.files().list().execute()

//                    for (file in result.files){
                        Log.d("SHASHANK", "readContentsFromDrive:${result.files.map { it.name }}  ")
//                    }
//                    val outputStream: OutputStream = ByteArrayOutputStream()
//
//                    googleDriveService.files().get("1jh6_vEyfcVmLru-N5V_4m1w5nIpQLJ5J")
//                        .executeMediaAndDownloadTo(outputStream)
//                    Log.d("SHASHANK", "readContentsFromDrive: " + (outputStream.toString()))

                } catch (userAuthEx: UserRecoverableAuthIOException) {

                    Log.d("SHASHANK", "uploadFileToGDrive: USER RECOVERABLE AUTH IO EXCEPTION")
                    startActivity(context, userAuthEx.intent, null)
                } catch (e: Exception) {
                    e.printStackTrace()
                    Log.d("", e.toString())

                }
            }
        }

    }

    private enum class ErrorCode {
        GOOGLE_USER_NOT_FOUND;

    }
}


/*//                    val fileList = googleDriveService.Files().list().execute()
//                    if (fileList != null) {
//                        val result = fileList.files.filter {
//                            it.name=="key.txt"
//                        }.firstOrNull()
//                        Log.d("SHASHANK", "readContentsFromDrive: ${result?.webContentLink}")
//                    } else {
//                        Log.d("SHASHANK", "readContentsFromDrive: NOSUCHFILE")
//
//                    }


//1jh6_vEyfcVmLru-N5V_4m1w5nIpQLJ5J*/

