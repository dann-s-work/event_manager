import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:event_manager/views/auth/signout.dart';
import 'package:event_manager/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup_Page extends StatefulWidget {
  const Signup_Page({super.key});

  @override
  State<Signup_Page> createState() => __MySignup_PageState();
}

class __MySignup_PageState extends State<Signup_Page> {
  final FirebaseServices _auth = FirebaseServices();
  TextEditingController authnameController = TextEditingController();
  TextEditingController authemailController = TextEditingController();
  TextEditingController authaddressController = TextEditingController();
  TextEditingController authphoneController = TextEditingController();
  TextEditingController authpasswordController = TextEditingController();
  @override
  void dispose() {
    authnameController.dispose();
    authemailController.dispose();
    authpasswordController.dispose();
    super.dispose();
  }

  bool obscureauthPassword = true;
  void togglePassword() {
    setState(() {
      obscureauthPassword = !obscureauthPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 50.0,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 30,
                children: [
                  Text('SignUp'),

                  appTextField(
                    controller: authnameController,
                    icon: Icons.person,
                    label: 'Name',
                    hint: "Enter name here",
                  ),
                  appTextField(
                    controller: authemailController,
                    icon: Icons.email,
                    label: 'Email',
                    hint: 'Enter Email Here',
                  ),
                  appTextField(
                    controller: authaddressController,
                    label: 'Address',
                    icon: Icons.location_city,
                    hint: 'Enter Address here',
                  ),
                  appTextField(
                    controller: authphoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    hint: 'Enter Phone Number here',
                  ),
                  appPasswordField(
                    controller: authpasswordController,
                    label: 'Password',
                    hint: 'Enter Your Password',
                    icon: Icons.lock,
                    obscureText: obscureauthPassword,
                    toggleObscure: togglePassword,
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (authnameController.text.isEmpty ||
                          authemailController.text.isEmpty ||
                          authaddressController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('All Fileds are Required')),
                        );
                        return;
                      } else {
                        try {
                          User? user = await _auth.signUpwithemailandpassword(
                            authemailController.text.trim(),
                            authpasswordController.text.trim(),
                          );
                          if (user != null) {
                            print('user is successfully created');
                            print('UID: ${user.uid}');

                            try {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .set({
                                    'name': authnameController.text.trim(),
                                    'email': authemailController.text.trim(),
                                    'address': authaddressController.text
                                        .trim(),
                                    'phonenumber': authphoneController.text
                                        .trim(),
                                    'timestamp': FieldValue.serverTimestamp(),
                                  });
                              print('USER SAVED ✅');
                            } catch (firestoreError) {
                              print('Firestore save error: $firestoreError');
                              return; // stop navigation if save fails
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signout(),
                              ),
                            );
                          } else {
                            print('some error occurred');
                          }
                        } catch (e) {
                          print('Error:$e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error Saving Data')),
                          );
                        }
                      }
                    },
                    child: Text("Next_Page"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
