import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sneaker_store_app/authentication/firebase_auth/utils/utils.dart';
import 'package:sneaker_store_app/homepage.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  // EMAIL SIGN-UP
  Future<void> signUpWithMail({
    required String username,
    required String mail,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _auth.setLanguageCode('en');
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );

      // Add user to Firestore
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': mail,
      });

      // Send email verification
      if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        if (context.mounted) {
          showSnackbar(context, 'Email verification sent. Please verify.');
        }
      }
    } on FirebaseAuthException catch (e) {
      // Provide a default error message if `e.message` is null
      final errorMessage = e.message ?? 'An error occurred during sign-up';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
    }
  }

  // USER SIGN-IN WITH EMAIL AND PASSWORD
  Future<void> userSignin({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Query Firestore for the user document where 'username' matches the entered username
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
          
      if (userSnapshot.docs.isNotEmpty) {
        String mail = userSnapshot.docs.first['email'];

        // Sign in the user
        await _auth.signInWithEmailAndPassword(email: mail, password: password);

        // Check if the user is verified
        if (_auth.currentUser!.emailVerified) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            );
          }
        } else {
          // Prompt them to verify their email
          if (context.mounted) {
            showSnackbar(context, 'Please verify your email to proceed.');
            await _auth.currentUser!.sendEmailVerification();
          }
        }
      } else {
        // Handle user not found case
        if (context.mounted) {
          showSnackbar(context, 'No user found for that username.');
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      final errorMessage = e.message ?? 'An error occurred during sign-in';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
    } catch (e) {
      // Handle any other exceptions
      if (context.mounted) {
        showSnackbar(context, 'An unexpected error occurred');
      }
    }
  }

  // EMAIL VERIFICATION
  Future<void> mailVerification(BuildContext context) async {
    try {
      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        if (context.mounted) {
          showSnackbar(context, 'Email verification sent!');
        }
      } else {
        if (context.mounted) {
          showSnackbar(context, 'Email is already verified.');
        }
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message ?? 'Failed to send verification email';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
    }
  }

  // GOOGLE SIGN-IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Sign in to Firebase
        await FirebaseAuth.instance.signInWithCredential(credential);

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        }
      }
    } catch (e) {
      // Handle any errors during Google Sign-In
      if (context.mounted) {
        showSnackbar(context, 'Google Sign-In failed: ${e.toString()}');
      }
    }
  }
  // PASSWORD RESET
  Future<void> resetPassword (BuildContext context)async{
    try {
     User? user = _auth.currentUser;
      if (user != null && user.email != null){
         await _auth.sendPasswordResetEmail(email: user.email!);
      if (context.mounted) {
        showSnackbar(context, 'An email has been sent to your inbox to reset your password.');
        }
      } else{
        showSnackbar(context, 'No User Found.');
      }
     
    }  on FirebaseAuthException catch (e) {
      if (context.mounted) {
     showSnackbar(context, 'An unexpected error occurred, please try again: ${e.toString()}');
      }
    }
 }
 // FORGOT PASSWORD
 Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        showSnackbar(context, 'Password reset email sent. Check your inbox.');
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message ?? 'Failed to send password reset email';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
}
  }
}
