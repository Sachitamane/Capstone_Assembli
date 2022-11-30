import 'package:assembli/services/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:assembli/globals.dart' as globals;

class InstructorCreateAnnouncements extends StatefulWidget {
  //const InstructorCreateAnnouncements({super.key});
  final int crn;
  //final int rnum;

  const InstructorCreateAnnouncements({
    Key? key,
    required this.crn,
    //required this.rnum
  }) : super(key: key);

  @override
  State<InstructorCreateAnnouncements> createState() => _InstructorCreateAnnouncementsState();
}

class _InstructorCreateAnnouncementsState extends State<InstructorCreateAnnouncements> {
  final dateController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Used to validate user input

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
                  child: Text('Enter announcement details'),
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
                  controller: messageController,
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
                        ctrl.createAnnouncement(widget.crn, dateController.text, messageController.text);
                        
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