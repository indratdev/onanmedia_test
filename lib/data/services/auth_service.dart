import 'package:firebase_auth/firebase_auth.dart';

import 'package:onanmedia_test/data/services/signsignup.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

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
