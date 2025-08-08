import 'package:flutter/material.dart';

class Signout extends StatefulWidget {
  const Signout({super.key});

  @override
  State<Signout> createState() => _MyEvent_ScreenState();
}

class _MyEvent_ScreenState extends State<Signout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Container(
                child: Text('WelCome to SignUp Page',style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
              
              ),
               ElevatedButton(onPressed: 
          (){
            Navigator.pushNamed(context, '/login');
          }, child: Text('SignOut')),
            ],
          ),
          
         
        ),
      ),
    );
  }
}