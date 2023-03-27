package com.example.test_project

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import android.util.Log
import android.widget.Toast
import androidx.core.content.ContextCompat.startActivity
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.google.api.client.extensions.android.http.AndroidHttp
import com.google.api.client.googleapis.extensions.android.gms.auth.GoogleAccountCredential
import com.google.api.client.googleapis.extensions.android.gms.auth.UserRecoverableAuthIOException
import com.google.api.client.http.FileContent
import com.google.api.client.json.jackson2.JacksonFactory
import com.google.api.client.util.IOUtils
import com.google.api.services.drive.Drive
import com.google.api.services.drive.DriveScopes
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException

open class GDriveExt {
    companion object {
        const val CONST_SIGN_IN = 34;
        const val CONST_G_DRIVE = 111;
        private const val TAG = "MainActivity"

        @Throws(IOException::class)
        fun Activity.createTemporaryFile(fileName: String, fileContent: String): File {
            val suffix = ".txt"
            val outputFile = File.createTempFile(fileName, suffix, cacheDir)
            outputFile.writeText(fileContent)
            Log.d(TAG, "createTemporaryFile: ${outputFile.absolutePath}")
            return outputFile
        }

    }

    private lateinit var googleAuth: GoogleSignInClient

    fun init(activity: Activity) {
        val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
            .requestIdToken("917456096698-2f7kjvhfo9eslmvq5ls51iejkcbmh6q9.apps.googleusercontent.com")
            .requestEmail().build()

        googleAuth = GoogleSignIn.getClient(activity, gso)
    }

    fun googleSignIN(activity: Activity) {
        val account = GoogleSignIn.getLastSignedInAccount(activity)
        if (account == null) {
            val signInIntent = googleAuth.signInIntent
            activity.startActivityForResult(signInIntent, CONST_SIGN_IN)
        }
    }

    fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
        activity: Activity,
        onResult: GDriveResultCallback<FirebaseUser>
    ) {
        if (requestCode == CONST_SIGN_IN) {
            val task = GoogleSignIn.getSignedInAccountFromIntent(data)
            try {
                val accout = task.getResult(ApiException::class.java)
                activity.firebaseAuthWithGoogle(accout.idToken)
            } catch (e: ApiException) {
                Toast.makeText(activity, "${e}", Toast.LENGTH_LONG).show()
            }
        }
        if (requestCode == CONST_G_DRIVE && resultCode == RESULT_OK) {
            val selectedFile = data!!.data //The uri with the location of the file
            val file = activity.makeCopy(selectedFile!!)
//            Toast.makeText(this, selectedFile.toString(), Toast.LENGTH_LONG).show()
//            uploadFileToGDrive(activity, file, )
        }
    }

    private fun Activity.firebaseAuthWithGoogle(idToken: String?) {
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        FirebaseAuth.getInstance().signInWithCredential(credential).addOnCompleteListener(this) {
            if (it.isSuccessful) {
                val user = FirebaseAuth.getInstance().currentUser
                updateUI(user)
            } else {
                updateUI(null)
            }
        }
    }

    private fun Context.updateUI(user: FirebaseUser?) {
        Toast.makeText(this, "Firebase user available:  ${user != null}", Toast.LENGTH_LONG).show();
    }

    fun getDriveService(context: Context): Drive {
        GoogleSignIn.getLastSignedInAccount(context).let { googleAccount ->
            val credential = GoogleAccountCredential.usingOAuth2(
                context, listOf(DriveScopes.DRIVE_FILE)
            )
            credential.selectedAccount = googleAccount!!.account!!
            return Drive.Builder(
                AndroidHttp.newCompatibleTransport(),
                JacksonFactory.getDefaultInstance(),
                credential
            ).setApplicationName(context.getString(R.string.app_name)).build()
        }
        var tempDrive: Drive
        return tempDrive
    }

    fun uploadFileToGDrive(context: Context, file: File, mDrive: Drive) {
        mDrive.let { googleDriveService ->
            GlobalScope.launch {
                try {
//                    val fileName = "Ticket"
                    val raunit = file
                    val gfile = com.google.api.services.drive.model.File()
                    gfile.name = "keys.txt"
                    val mimetype = "text/plain"
                    val fileContent = FileContent(mimetype, raunit)
                    var fileid = ""


                    withContext(Dispatchers.Main) {

                        withContext(Dispatchers.IO) {
                            launch {
                                var mFile =
                                    googleDriveService.Files().create(gfile, fileContent).execute()
                                        .also {
                                            Log.d("Shashank", "uploadFileToGDrive: ${it.parents}")
                                        }
                            }
                        }


                    }


                } catch (userAuthEx: UserRecoverableAuthIOException) {

                    Log.d(TAG, "uploadFileToGDrive: USER RECOVERABLE AUTH IO EXCEPTION")
                    startActivity(context, userAuthEx.intent, null)
                } catch (e: Exception) {
                    e.printStackTrace()
                    Log.d("", e.toString())

                }
            }
        }

    }

    fun Activity.makeCopy(fileUri: Uri): File {
        val parcelFileDescriptor =
            applicationContext.contentResolver.openFileDescriptor(fileUri, "r", null)
        val inputStream = FileInputStream(parcelFileDescriptor!!.fileDescriptor)
        val file = File(
            applicationContext.filesDir, getFileName(applicationContext.contentResolver, fileUri)
        )
        val outputStream = FileOutputStream(file)
        IOUtils.copy(inputStream, outputStream)
        return file;
    }

    private fun Activity.getFileName(contentResolver: ContentResolver, fileUri: Uri): String {

        var name = ""
        val returnCursor = contentResolver.query(fileUri, null, null, null, null)
        if (returnCursor != null) {
            val nameIndex = returnCursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
            returnCursor.moveToFirst()
            name = returnCursor.getString(nameIndex)
            returnCursor.close()
        }

        return name
    }


}

interface GDriveResultCallback<T> {
    fun onSuccess(data: T);
    fun onError(errorMessage: String)
}