import 'package:assembli/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  AppUser? userInstance;


  Future<void> getUser() async{

  }
  
   getType() async{

  }
  
}