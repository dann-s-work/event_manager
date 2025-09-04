import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
final  _firestore = FirebaseFirestore.instance;
final  _auth = FirebaseAuth.instance;

Future<void> showEditDilog(
  BuildContext context,String docId,String currentTitle,String currentDesc
)async{
  final titleController= TextEditingController(text: currentTitle);
  final descriptionController = TextEditingController(text: currentDesc);
  await showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('Edit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
            
          ),

        ],
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
        ElevatedButton(onPressed: ()async{
          await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('todos').doc(docId).update({
            'title':titleController.text.trim(),
            'description':descriptionController.text.trim(),
          });
          Navigator.pop(context);
        }, child: Text('Update')),
      ],
    );
  }
  
  );

}