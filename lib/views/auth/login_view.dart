import 'package:event_manager/custom_widgets/app_snackbar.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:event_manager/views/auth/firebase_services.dart';
import 'package:event_manager/views/auth/signup_view.dart';
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
    TextEditingController emailController= TextEditingController();
    TextEditingController passwordController= TextEditingController();
    void togglePsswordVisibility(){
      setState(() {
        _obscurepassword= !_obscurepassword;
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
              padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 50),
              child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 30,
                  children: [
                      Text("Login"),
                     
                      appTextField(controller: emailController, label: 'Email', icon: Icons.email, hint: 'Enter Email here'),
                     appPasswordField(controller: passwordController, label: 'Password',hint: 'Enter Password here', icon: Icons.lock,obscureText: _obscurepassword,
                     toggleObscure: togglePsswordVisibility,
                    ),
                      ElevatedButton(onPressed: ()async{

                        if (emailController.text.isEmpty|| passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email and Password are required')));

                          return;
                        }else{
                        try {
                              User? user = await _auth.signInwithemailandpassword(emailController.text,passwordController.text);
                          if(user!=null){
                            QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: emailController.text.trim()).get();
                           if (snapshot.docs.isNotEmpty) {
                             print('User profile Data : ${snapshot.docs.first.data()}');
                             showAppSnackbar(context: context, message: 'Login Successfully');
                             Navigator.pushNamed(context, '/signout');

                           }else{
                            showAppSnackbar(context: context, message: 'No profile found for this user');
                           }
                          
                          
                          
                          } else{
                                showAppSnackbar(context: context, message: 'Invalid Credentials');
                          }
                        } catch (e) {
                          print("Error:$e");
                          showAppSnackbar(context: context, message: 'error:$e');
                        }
                      
                        }
                        }, child: Text('Login'))
                  ],
              ),
            ),
          ),
        ),
    );
  }
}