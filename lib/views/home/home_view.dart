import 'package:event_manager/const/app_images.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar: AppBar(
            title: Text('Home View'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Center(
              child: Text(
                'Welcome to the Home View!',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Image.asset(
              AppImages.walpaper1,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text('Image 1', style: TextStyle(fontSize: 18)),
            Image.asset(
              AppImages.walpaper2,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text('Image 1', style: TextStyle(fontSize: 18)),
            Image.asset(
              AppImages.walpaper3,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text('Image 1', style: TextStyle(fontSize: 18)),
            
          ],
        ),
    );
  }
}