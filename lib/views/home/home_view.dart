import 'package:event_manager/const/app_images.dart';
import 'package:event_manager/custom_widgets/image_widgets.dart';
import 'package:event_manager/views/auth/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
 
  HomeView({super.key});
  

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

        appBar: AppBar(
            title: Text('Home View'),
            centerTitle: true,
        ),
        body: Column(
            spacing: 150,
          children: [
            Center(
                  child: Text(
                    'Welcome to home page',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 30,
                    children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.blue, width: 4),
                                
                                ),
                              child: ClipOval(child: Image(image: AssetImage('assets/images/event.jpg'),fit: BoxFit.cover,width: 300,height: 300,))
                    ),
                          ElevatedButton(onPressed: (){
                            Navigator.pushNamed(context,'/login');
                          }, child: Text("Login")),
                          ElevatedButton(onPressed: (){
                            Navigator.pushNamed(context, '/signup');
                          }, child: Text("SigUp")),
                          

                      ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}