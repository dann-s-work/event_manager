import 'package:flutter/material.dart';

class MyEvent_Screen extends StatefulWidget {
  const MyEvent_Screen({super.key});

  @override
  State<MyEvent_Screen> createState() => _MyEvent_ScreenState();
}

class _MyEvent_ScreenState extends State<MyEvent_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            child: Text('Event_Manager'),
          ),
        ),
      ),
    );
  }
}