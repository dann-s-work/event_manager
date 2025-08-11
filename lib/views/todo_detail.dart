import 'package:flutter/material.dart';

class TodoDetail extends StatelessWidget {
  final String title;
  final String description;
   TodoDetail({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Padding(padding: EdgeInsets.all(20),
      child: Text(description.isEmpty ?"No Description Provided":description,),
      ),
    );
  }
}