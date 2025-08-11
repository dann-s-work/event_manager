import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpwithemailandpassword(String email,String password)async{
        try {
          UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
            return credential.user;
          
        }  on FirebaseAuthException catch (e) {
      print("Sign Up Error Code: ${e.code}");
      print("Sign Up Error Message: ${e.message}");
      rethrow; 
    }
  }
  Future<User?> signInwithemailandpassword(String email, String password)async{
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error Code: ${e.code}");
      print("Sign Up Error Message: ${e.message}");
      rethrow; // so UI can also handle it
    }
  }
}