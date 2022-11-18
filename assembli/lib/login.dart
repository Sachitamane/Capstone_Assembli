//import 'package:assembli/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formkey = GlobalKey<FormState>();
  //bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Clean up the controller

  //comment out dispose method if using rool from git rool
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 194, 168),
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *.70,
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 150,
                        child: Image.asset('assets/assembliLogo.png')
                      ),
                      
                      TextFormField(     
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter valid ttu email id'
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (value.endsWith('@ttu.edu') == false)//!RegExp(
                              //"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            //.hasMatch(value))
                            {
                              return ("Please enter an adress within @ttu.edu");
                            } else {
                              
                              return null;
                            }
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("please enter valid password min. 6 character");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 179, 194, 168),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 179, 194, 168))
                                ),
                          onPressed: signIn,
                          /*
                          onPressed: () async{
                            dynamic result = signIn;
                            if(result == null){
                              setState(() {
                                loading = false;
                              });
                            }
                            
                          },
                          */
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        
                      ),
                      const SizedBox(
                        height: 85,
                      ),
                      const Text('Having trouble logging in? Contact your Admin for help')
                    ]
                  ),
                ),  
              )  
            ),
          ],
        ),
      ),
    );
  }
/*
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('type') == "instructor") {
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  const InstructorLanding(),
          ),
        );
        }else{
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  const StudentLanding(),
          ),
        );
        }
      } else {
        debugPrint('Document does not exist on the database');
      }
    });
  }
*/
  Future signIn() async {
    /*
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    ); 
    */

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      //route();
    } on FirebaseAuthException catch (e) {
      debugPrint('error found : ${e.toString()}  ');
    }
    
   // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
