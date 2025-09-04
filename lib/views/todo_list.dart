import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/views/add_todo.dart';
import 'package:event_manager/views/home/todo_editing_dilog.dart';
import 'package:event_manager/views/todo_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _firestore =FirebaseFirestore.instance;
   TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('To-do List'),
      actions: [
        IconButton(onPressed: ()async{
          await _auth.signOut();
          Navigator.pushReplacementNamed(context, "/login");
        }, icon: Icon(Icons.logout))
      ],
      ),
      body: StreamBuilder<QuerySnapshot>(stream: _firestore
      .collection('users').doc(user!.uid).collection('todos').orderBy('createdAt',descending: true).snapshots(),
      
       builder:(context,snapshot){
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'),);

        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        final todos = snapshot.data!.docs;
        if (todos.isEmpty) {
          return Center(child: Text('No Tasks yet. Add one!'),);
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context,index){
          final todo =todos[index];
          return ListTile(
            title: Text(todo['title']),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>TodoDetail(
              title: todo['title'],
              description : todo['description']
            ))),
            trailing:PopupMenuButton<String>(
              onSelected: (Value)async{
                if (Value=='edit') {
                  
                  showEditDilog(context,
                  todo.id,
                  todo['title'],
                  todo['description']);
                } else if(Value=='delete'){
                    await _firestore.collection('users').doc(user.uid).collection('todos').doc(todo.id).delete();
                }
              },
              itemBuilder:(BuildContext content)=>[
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),)
              ])
          );
        });
        
       } ),
       floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTodo()));

       },
       child: Icon(Icons.add),
       ),
       
    );
  }


}
