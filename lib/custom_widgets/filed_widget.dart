import 'package:event_manager/const/controller/controller.dart';
import 'package:flutter/material.dart';
class MyFiled_Name extends StatelessWidget {
  const MyFiled_Name({super.key, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
  keyboardType: TextInputType.name,
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.person),
    hint: Text('Enter Your Name'),
    labelText: 'Enter Your Name',
  ),
 );
  }
}
class MyFiled_Email extends StatelessWidget {
  const MyFiled_Email({super.key, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
   return TextField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.email),
      hint: Text('Enter Your Email'),
      labelText: 'Enter Your Email'
    ),
  );
  }
}
class MyFiled_Address extends StatelessWidget {
  const MyFiled_Address({super.key, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: addressController,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.location_city),
        hint: Text('Enter Your Address'),
        labelText: 'Enter Your Address'
      ),
  );
  }
}
