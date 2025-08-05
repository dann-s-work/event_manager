import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/const/controller/controller.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MySignup_Page extends StatefulWidget {
  const MySignup_Page({super.key});

  @override
  State<MySignup_Page> createState() => __MySignup_PageState();
}

class __MySignup_PageState extends State<MySignup_Page> {
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
          
                  MyFiled_Name(controller:nameController),
                  MyFiled_Email(controller:emailController),
                  MyFiled_Address(controller:addressController),
                  ElevatedButton(onPressed: ()async{
                    String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String Address = addressController.text.trim();
                    if (name.isEmpty|| email.isEmpty|| Address.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All Fileds are Required')));
                      return;
                    }
                    try {
                      await FirebaseFirestore.instance.collection('user').add({
                        'name1':name,
                        'email1':email,
                        'address1':Address,
                        'timestamp':FieldValue.serverTimestamp(),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Successfully')));
                    } catch (e) {
                      print('Error:$e');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Saving Data')));
                    }
                  }, child: Text("Next_Page"),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}