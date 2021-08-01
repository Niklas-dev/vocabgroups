import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocalgroups/Authentication/Database.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signOut() async {
    _auth.signOut();
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future signUp(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      user.updateDisplayName(username);
      await DatabaseService(uid: user.uid)
          .updateUserData(username, user.email!);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
