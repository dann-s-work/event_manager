
import 'package:flutter/material.dart';


Widget appTextField({required TextEditingController controller, String hint="Enter here",required String label, required IconData icon}){
  return TextField(
      controller: controller,
  keyboardType: TextInputType.name,
  decoration: InputDecoration(
    prefixIcon: Icon(icon),
    hint: Text(hint),
    labelText: label,
  ),
 );
}
