import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/controllers/add_todo_contoller.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:event_manager/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class AddTodo extends StatefulWidget {
//   const AddTodo({super.key});

//   @override
//   State<AddTodo> createState() => _AddTodoState();
// }

// class _AddTodoState extends State<AddTodo> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   Future<void> _savetodo()async{
//     User? user = _auth.currentUser;
//     if (_titleController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Your Title')));
//     return;
//   }
//   await _firestore.collection('users').doc(user!.uid).collection('todos').add({
//     'title':_titleController.text,
//     'description':_descriptionController.text,
//     'createdAt':FieldValue.serverTimestamp(),
//   });
//   Navigator.pop(context);
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Tak'),),
//     body: Column(
//       spacing: 40,
//       children: [
//         TextField(
//           controller: _titleController,
//           decoration: InputDecoration(labelText: 'Title'),
//         ),
//         TextField(
//           controller: _descriptionController,
//           decoration: InputDecoration(labelText: 'Description'),
//           maxLines: 3,
//         ),
//         ElevatedButton(onPressed: _savetodo, child: Text('Save Task'))
//       ],
//     ),
//     );
//   }
// }

class AddtodoView extends StatelessWidget {
  const AddtodoView({super.key});

  @override
  Widget build(BuildContext context) {
    AddTodoController controller = AddTodoController();
     final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text('Add Tak')),
      body: Form(
        key: formKey,
        child: Column(
          spacing: 40,
          children: [
            customTextField(
              controller: controller.titleController,
              label: 'Title',
              hint: 'Enter your task title',
              maxLines: 2,
              validator:(v)=>FormValidator.validateNotEmpty(v),
            ),
            customTextField(
              controller: controller.titleController,
              label: 'Description',
              hint: 'Enter your task description',
              maxLines: 6,
              validator:(v)=>FormValidator.validateNotEmpty(v),
            ),
            
            ElevatedButton(
              onPressed: () {
                if(formKey.currentState!.validate()){
                controller.savetodo(context);
                }
              },
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
