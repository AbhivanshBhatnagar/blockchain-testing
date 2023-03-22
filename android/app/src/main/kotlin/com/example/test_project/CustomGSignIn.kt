package com.example.test_project

import android.app.Activity
import android.content.Intent
import android.util.Log
import androidx.activity.result.ActivityResult
import androidx.activity.result.ActivityResultCaller
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.tasks.Task
import com.google.firebase.auth.AuthCredential
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.GoogleAuthProvider
import java.util.*


class CustomGSignIn(private val act: Activity) {
    protected val activityLauncher: ActivityResultHandler<Intent, ActivityResult>
    private val mAuth: FirebaseAuth
    private var mGoogleSignInClient: GoogleSignInClient? = null
    var authStateListener: FirebaseAuth.AuthStateListener? = null
    var firstTimeUserStatus = false
        private set
    private val listeners: MutableList<CustomSignedInListener>

    init {
        mAuth = FirebaseAuth.getInstance()
        listeners = ArrayList<CustomSignedInListener>()
        activityLauncher =
            ActivityResultHandler.registerActivityForResult(act as ActivityResultCaller)
    }

    fun addListener(listener: CustomSignedInListener) {
        listeners.add(listener)
    }

    fun signInOnClick() {
        val signInIntent: Intent = mGoogleSignInClient.getSignInIntent()
        activityLauncher.launch(signInIntent) { result ->
            if (result.getResultCode() === Activity.RESULT_OK) {
                val data: Intent = result.getData()
                val task: Task<GoogleSignInAccount> =
                    GoogleSignIn.getSignedInAccountFromIntent(data)
                try {
                    // Google Sign In was successful, authenticate with Firebase
                    val account: GoogleSignInAccount =
                        task.getResult(ApiException::class.java)
                    Log.d(
                        TAG,
                        "firebaseAuthWithGoogle:" + account.getId()
                    )
                    firebaseAuthWithGoogle(account.getIdToken())
                } catch (e: ApiException) {
                    // Google Sign In failed, update UI appropriately
                    Log.w(TAG, "Google sign in failed", e)
                }
            }
        }
    }

    fun handleSignedIn() {
        Log.v(TAG,
            "User Signed In: " + Objects.requireNonNull(FirebaseAuth.getInstance().getCurrentUser().getEmail()
        )
        broadcastSignedIn()
    }

    fun setUpSignInButton() {
        Log.v(TAG, "No User found signed in already")
        val gso: GoogleSignInOptions =
            com.google.android.gms.auth.api.signin.GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestIdToken(act.getString(R.string.default_web_client_id))
                .requestEmail()
                .build()
        mGoogleSignInClient = GoogleSignIn.getClient(act, gso)
    }

    private fun firebaseAuthWithGoogle(idToken: String) {
        Log.v(TAG, "FirebaseAuthWithGoogle: $idToken")
        val credential: AuthCredential = GoogleAuthProvider.getCredential(idToken, null)
        mAuth.signInWithCredential(credential).addOnCompleteListener { task ->
            if (task.isSuccessful) {
                Log.v(TAG, "Sign In Success")
                val user: FirebaseUser? = mAuth.currentUser
                firstTimeUserStatus = (task.result.additionalUserInfo?.isNewUser ?: broadcastSignedIn()) as Boolean
            } else {
                Log.v(
                    TAG,
                    "Sign In Failed: " + task.exception
                )
                broadcastSignedIn()
            }
        }
    }

    private fun broadcastSignedIn() {
        for (listener in listeners) {
            listener.userSignedIn()
        }
    }

    fun getmAuth(): FirebaseAuth {
        return mAuth
    }

    companion object {
        private val TAG = CustomGSignIn::class.java.simpleName
    }
}
