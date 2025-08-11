
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget appTextField({required TextEditingController controller, String hint="",required String label, required IconData icon,}){
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
Widget appPasswordField({required TextEditingController controller, String hint='', required String label,bool obscureText=false,
String obscuringcharacter='*', required IconData icon, VoidCallback? toggleObscure,
}){
return TextField(
 controller: controller,
 keyboardType: TextInputType.visiblePassword,
 obscureText:obscureText,
  obscuringCharacter: obscuringcharacter,
 decoration: InputDecoration(
  hint: Text(hint),
  labelText: label,
  prefixIcon: Icon(icon),
  suffixIcon: toggleObscure != null ? IconButton(icon: Icon(obscureText ? Icons.visibility_off: Icons.visibility),
  onPressed: toggleObscure,
  ): null

 ),
);
}