import 'package:event_manager/const/app_images.dart';
import 'package:event_manager/custom_widgets/image_widgets.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar: AppBar(
            title: Text('Home View'),
            centerTitle: true,
        ),
        body: Column(
            spacing: 20,
          children: [
            Center(
                  child: Text(
                    'Welcome to the Home View!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                                imageWithText(imagePath: AppImages.walpaper1, text: 'Minecrafter'),
                                imageWithText(imagePath: AppImages.walpaper2, text: 'Spiderman'),
                                imageWithText(imagePath: AppImages.walpaper3, text: 'Sad Spider'),    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}