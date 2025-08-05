import 'package:event_manager/const/controller/controller.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLogin_Page extends StatefulWidget {
  const MyLogin_Page({super.key});

  @override
  State<MyLogin_Page> createState() => _MyLogin_PageState();
}

class _MyLogin_PageState extends State<MyLogin_Page> {
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
                     MyFiled_Name(controller: nameController,),
                      MyFiled_Email(controller: emailController,),
                      MyFiled_Address(controller: addressController,),
                      ElevatedButton(onPressed: ()async{
                        String name= nameController.text.trim();
                        String email = emailController.text.trim();
                        String Address =addressController.text.trim();
                        if (name.isEmpty|| email.isEmpty|| Address.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All Fields are Required')));
                          return;
                          
                        }
                        try {
                          await FirebaseFirestore.instance.collection('user').add({
                            'name':name,
                             'email':email,
                             'address':Address,
                             'timestamp':FieldValue.serverTimestamp(),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Successfully'))
                          );
                          Navigator.pushNamed(context, '/event');
                        } catch (e) {
                          print("Error:$e");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Saving Data')));
                        }
                        
                      }, child: Text('Events'))
                  ],
              ),
            ),
          ),
        ),
    );
  }
}