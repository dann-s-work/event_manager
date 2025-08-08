import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:event_manager/views/auth/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MySignup_Page extends StatefulWidget {
  const MySignup_Page({super.key});

  @override
  State<MySignup_Page> createState() => __MySignup_PageState();
}

class __MySignup_PageState extends State<MySignup_Page> {
  final FirebaseServices _auth = FirebaseServices();
   TextEditingController authnameController=TextEditingController();
    TextEditingController authemailController =TextEditingController();
    TextEditingController authaddressController = TextEditingController();
    TextEditingController authpasswordController = TextEditingController();
    @override
    void dispose(){
      authnameController.dispose();
      authemailController.dispose();
      authpasswordController.dispose();
      super.dispose();
    }
  bool obscureauthPassword = true;
  void togglePassword(){
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
              vertical: 50.0,horizontal: 50.0
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 30,
                children: [
                  Text('SignUp',),
          
                  appTextField(controller: authnameController,icon: Icons.person, label: 'Name', hint: "Enter name here"),
                  appTextField(controller:authemailController,icon:Icons.email, label: 'Email',hint:'Enter Email Here'),
                  appTextField(controller: authaddressController, label: 'Address', icon: Icons.location_city, hint: 'Enter Address here'),
                  appPasswordField(controller: authpasswordController, label:'Password', hint: 'Enter Your Password', icon: Icons.lock,
                  obscureText: obscureauthPassword, toggleObscure: togglePassword),

                  ElevatedButton(onPressed: ()async{
                     
                      
                    if (authnameController.text.isEmpty|| authemailController.text.isEmpty|| authaddressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All Fileds are Required')));
                      return;
                    }else{
                      
                    try {
                      User? user= await _auth.signUpwithemailandpassword(authemailController.text,authpasswordController.text);
                      if (user!= null) {
                              print('user is successfully created');
                               await FirebaseFirestore.instance.collection('user').add({
                        'name':authnameController.text,
                        'email':authemailController.text,
                        'address': authaddressController.text,
                        'password': authpasswordController.text,
                        'timestamp':FieldValue.serverTimestamp(),
                      });
                       Navigator.pushNamed(context, '/signout');
                      }else{
                         print('some error occurred');
                                 }
                     
                     
                      
                    } catch (e) {
                      print('Error:$e');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Saving Data')));
                    }
                    
                  } ;
                    
                    },child: Text("Next_Page"),)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
