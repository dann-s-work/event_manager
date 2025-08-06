import 'package:event_manager/custom_widgets/app_snackbar.dart';
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
    TextEditingController nameController=TextEditingController();
    TextEditingController emailController= TextEditingController();
    TextEditingController addressController= TextEditingController();
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
                     appTextField(controller: nameController,icon: Icons.person, label: 'Name', hint: "Enter name here"),
                      appTextField(controller: emailController, label: 'Email', icon: Icons.email, hint: 'Enter Email here'),
                     appTextField(controller: addressController, label: 'Address', icon: Icons.location_city, hint: 'Enter Address here'),
                      ElevatedButton(onPressed: ()async{
                        if (nameController.text.isEmpty|| emailController.text.isEmpty|| addressController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All Fields are Required')));
                          return;
                        }else{
try {
                          await FirebaseFirestore.instance.collection('user').add({
                            'name':nameController.text ,
                             'email':emailController.text,
                             'address':addressController.text,
                             'timestamp':FieldValue.serverTimestamp(),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Successfully'))
                          );
                          print('NAVIGATION');
                          Navigator.pushNamed(context, '/event');
                          
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