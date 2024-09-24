import 'dart:async';
import 'dart:math';

import 'package:balloon_pop/colors.dart';
import 'package:balloon_pop/constants.dart';
import 'package:balloon_pop/game.dart';
import 'package:balloon_pop/widgets/home_card.dart';
import 'package:balloon_pop/widgets/ring_image.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: KColors.primary,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              KColors.primary,
              KColors.primary.withOpacity(0.8),
              KColors.primary.withOpacity(0.8)
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Boy Image with consecutive rings inbackground
              RingImageWidget(),

              SizedBox(
                height: 15.0,
              ),

              HomeCard(
                onNextPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
