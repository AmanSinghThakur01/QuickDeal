import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  /// 🔵 Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Step 1: Trigger Google Sign-In
      final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled login
        return null;
      }

      // Step 2: Get auth details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Step 3: Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in with Firebase
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      return null;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  /// 🔴 Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  /// 👤 Current User
  User? get currentUser => _auth.currentUser;

  /// 🔄 Auth State Stream (useful for UI)
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}