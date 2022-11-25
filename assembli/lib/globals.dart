library globals;

import 'package:assembli/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

//reset these values  upon logout
//(app user, authUser will be dependent upon login)
User? authUser = FirebaseAuth.instance.currentUser;
AppUser? runningUser;
