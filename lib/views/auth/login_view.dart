import 'package:event_manager/custom_widgets/app_snackbar.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:event_manager/services/firebase_services.dart';
import 'package:event_manager/views/home/profile_update.dart';
import 'package:event_manager/views/todo_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLogin_Page extends StatefulWidget {
  const MyLogin_Page({super.key});

  @override
  State<MyLogin_Page> createState() => _MyLogin_PageState();
}

class _MyLogin_PageState extends State<MyLogin_Page> {
  final FirebaseServices _auth = FirebaseServices();
  bool _obscurepassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void togglePsswordVisibility() {
    setState(() {
      _obscurepassword = !_obscurepassword;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 30,
              children: [
                Text("Login"),

                appTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                  hint: 'Enter Email here',
                ),
                appPasswordField(
                  controller: passwordController,
                  label: 'Password',
                  hint: 'Enter Password here',
                  icon: Icons.lock,
                  obscureText: _obscurepassword,
                  toggleObscure: togglePsswordVisibility,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Email and Password are required'),
                        ),
                      );

                      return;
                    }
                    try {
                      print(passwordController.text);
                      print(emailController.text);

                      User? user = await _auth.signInwithemailandpassword(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                      if (user != null) {
                        QuerySnapshot snapshot = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where(
                              'email',
                              isEqualTo: emailController.text.trim(),
                            )
                            .get();
                        if (snapshot.docs.isNotEmpty) {
                          print(
                            'User profile Data : ${snapshot.docs.first.data()}',
                          );
                          //  showAppSnackbar(context: context, message: 'Login Successfully');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TodoList()),
                          );
                        }
                      } else {
                        showAppSnackbar(
                          context: context,
                          message: 'No profile found for this user',
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage;
                      switch (e.code) {
                        case 'user-not-found':
                          errorMessage = 'No user found for that email.';
                          break;
                        case 'wrong-password':
                          errorMessage =
                              'Wrong password provided for that user.';
                          break;
                        case 'invalid-email':
                          errorMessage = 'The email address is not valid.';
                          break;
                        default:
                          errorMessage = 'Login failed: ${e.message}';
                      }
                      showAppSnackbar(context: context, message: errorMessage);
                    } catch (e) {
                      showAppSnackbar(
                        context: context,
                        message: 'An unexpected error occurred: $e',
                      );
                    }
                  },
                  child: Text('Login'),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileUpdate(),
                          ),
                        );
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
