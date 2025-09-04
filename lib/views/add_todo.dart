import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Tak'),),
    body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 50.0),
          child: Column(
            spacing: 40,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                
              ),
              ElevatedButton(onPressed: _savetodo, child: Text('Save Task'))
            ],
          ),
        ),
      ),
    ),
    );
  }
    Future<void> _savetodo()async{
    User? user = _auth.currentUser;
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Your Title')));
    return;
  }
  await _firestore.collection('users').doc(user!.uid).collection('todos').add({
    'title':_titleController.text,
    'description':_descriptionController.text,
    'createdAt':FieldValue.serverTimestamp(),
  });
  Navigator.pop(context);
}
}