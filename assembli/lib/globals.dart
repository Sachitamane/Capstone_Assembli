library globals;

import 'package:assembli/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


/*
  AppUser runningUser = AppUser(
  email:null,
  rnum: null,
  type: null
);
*/
//reset these values upon logout
User? authUser = FirebaseAuth.instance.currentUser;
AppUser? runningUser;
/*
String? email;
int? rnum;
String? type;
String? fname;
String? lname;
List<Course>? schedule;
*/