import 'package:flutter/material.dart';

//class holds basis for profile destination; 
//will work similar to landing, linking other pages/states 
//(linked from navigationBar destination in landing.dart) 

class ProfilePage extends StatelessWidget {
const ProfilePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Center(
        child: Text("Profile Page"),
      );
  }
}