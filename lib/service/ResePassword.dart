



import 'package:firebase_auth/firebase_auth.dart';

class passowrdReset{


  FirebaseAuth auth = FirebaseAuth.instance;

  Future restPassword(String email){

    return auth.sendPasswordResetEmail(email: email);

  }


}