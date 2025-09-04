
import 'package:event_manager/views/auth/signout.dart';
import 'package:event_manager/views/auth/login_view.dart';
import 'package:event_manager/views/home/home_view.dart';
import 'package:event_manager/views/auth/signup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>HomeView(),
        '/login':(context)=>MyLogin_Page(),
        '/signup':(context)=>Signup_Page(),
        '/signout' : (context)=> Signout(),
      }
    );
  }
}
