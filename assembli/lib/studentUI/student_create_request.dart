import 'package:assembli/services/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:assembli/globals.dart' as globals;


// Takes user input and creates new document in "Request" collection
// upon pressing "submit" button, in pending status

class StudentCreateRequest extends StatefulWidget {
  //const StudentCreateRequest({super.key});
  final int crn;
  final int rnum;

  const StudentCreateRequest({
    Key? key,
    required this.crn,
    required this.rnum
  }) : super(key: key);

  @override
  State<StudentCreateRequest> createState() => _StudentCreateRequest();
}

class _StudentCreateRequest extends State<StudentCreateRequest> {
  // Make controller for each field in the request document
  final dateController = TextEditingController();
  final reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Used to validate user input

  /*
  CollectionReference requests =
      FirebaseFirestore.instance.collection('Request');
  */
  Control ctrl  = Control(authUser: globals.authUser, user: globals.runningUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 179, 194, 168),
      title: const Text('Assembli')
    ),
      resizeToAvoidBottomInset: false, // Keyboard overlay
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              // Display prompt
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: Color.fromARGB(255, 141, 143, 140),
                      fontSize: 23,
                      fontStyle: FontStyle.italic),
                  child: Text('Enter request details'),
                ),
              ),
              // Get date
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    hintText: 'Enter date of absence',
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Input date'; // Error text: no user input
                    }
                    return null;
                  },
                ),
              ),

              // Get reason
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason',
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Input reason'; // Error text: no user input
                    }
                    return null;
                  },
                ),
              ),

              // Submit button
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: SizedBox(
                  width: 110,
                  height: 45,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 179, 194, 168))),
                    onPressed: () {
                      // First check that every field contains text
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Then, update to database
                        ctrl.createRequest(widget.crn, dateController.text, reasonController.text, globals.runningUser!.rnum!, 'pending');
                        
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
