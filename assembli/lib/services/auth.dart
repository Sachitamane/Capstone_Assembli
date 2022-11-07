import 'package:firebase_auth/firebase_auth.dart';

//this class defines all of the methods that will interact with all 
//of the firebase auth services
class AuthService {


  //variables that start with an underscore means it is a private var
  final FirebaseAuth _auth = FirebaseAuth.instance;
    //sign in w/ email and password

    //registration is not supported in our app, considered administration func(DB only)
}