import 'package:flutter/material.dart';

Widget imageWithText(
  {
    required String imagePath,
    String text = 'Default Text',
  }
){
  return Column(children: [
                          Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Text(text, style: TextStyle(fontSize: 18)),
  ],);

}