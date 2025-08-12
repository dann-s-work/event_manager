import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTodoController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> savetodo(BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('todos')
          .add({
            'title': titleController.text,
            'description': descriptionController.text,
            'createdAt': FieldValue.serverTimestamp(),
          });
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving todo: $e')));
    }
  }
}
