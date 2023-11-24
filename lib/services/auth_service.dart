import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onanmedia_test/services/signsignup.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> registerUser(
      String email, String password) async {
    User? result;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // The user has been created successfully
      result = userCredential.user;
      print('User ID: ${result?.uid ?? ""}');
    } on FirebaseAuthException catch (e) {
      // Handle any errors that occur during the user creation process
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
    return SignInSignUpResult(user: result);
  }

  static Future<SignInSignUpResult> createUser({
    required String email,
    required String pass,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<SignInSignUpResult> signInWithEmail({
    required String email,
    required String pass,
  }) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static void signOut() {
    _auth.signOut();
  }
}
