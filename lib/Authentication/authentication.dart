import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocalgroups/Authentication/Database.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signOut() async {
    _auth.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user!;
      user.uid;
      return "user.uid";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used. Go to login page.";

        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong email/password combination.";

        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";

        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";

        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          return "Too many requests to log into this account.";

        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";

        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";

        default:
          return "Login failed. Please try again.";
      }
    }
  }

  Future<String?> signUp(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      user.updateDisplayName(username);
      await DatabaseService(uid: user.uid)
          .updateUserData(username, user.email!);
      DatabaseService()
          .dataCollection
          .doc(user.uid)
          .collection('books')
          .doc("Your first book")
          .set({
        'bookname': "Your first book",
        'index': null,
        'public': null,
        'leftColumnName': "Demo",
        'rightColumnName': "Demo",
        'leftContent': ["Left"],
        'rightContent': ["Right"],
      });

      return "";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);

      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used. Go to login page.";

        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong email/password combination.";

        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";

        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";

        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          return "Too many requests to log into this account.";

        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";

        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";

        case "weak-password":
          return "Password is too weak.";

        default:
          return "Register failed. Please try again.";
      }
    }
  }

  Future deleteUser(String email, String password) async {
    try {
      User user = _auth.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);

      final result = await user.reauthenticateWithCredential(credentials);

      await result.user!.delete();

      await DatabaseService().deleteUserDB(result.user!.uid);
      signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
