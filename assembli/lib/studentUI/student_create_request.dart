import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Takes user input and creates new document in "Request" collection
// upon pressing "submit" button, in pending status

class StudentCreateRequest extends StatefulWidget {
  const StudentCreateRequest({super.key});

  @override
  State<StudentCreateRequest> createState() => _StudentCreateRequest();
}

class _StudentCreateRequest extends State<StudentCreateRequest> {
  // Make controller for each field in the request document
  final cidController = TextEditingController();
  final dateController = TextEditingController();
  final reasonController = TextEditingController();
  final rnumController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Used to validate user input

  CollectionReference requests =
      FirebaseFirestore.instance.collection('Request');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              // Get cid
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: cidController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Course ID',
                    hintText: 'Enter Course ID',
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Input course ID'; // Error text: no user input
                    }
                    return null;
                  },
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

              // Get rnum
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: rnumController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'R Number',
                    hintText: 'Enter your R Number',
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Input R Number'; // Error text: no user input
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
                        FirebaseFirestore.instance.collection('Request').add({
                          'cid': cidController.text,
                          'date': dateController.text,
                          'reason': reasonController.text,
                          'rnum': rnumController.text,
                          'status': 'pending', // Saved as pending status
                        });
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
