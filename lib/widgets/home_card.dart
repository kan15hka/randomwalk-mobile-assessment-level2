import 'package:balloon_pop/colors.dart';
import 'package:balloon_pop/game.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  HomeCard({super.key, this.onNextPressed});
  VoidCallback? onNextPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.075),
              borderRadius: BorderRadius.circular(25.0),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1.5)),
          child: Column(
            children: [
              Text("Pop'nPlay",
                  style: TextStyle(
                      fontFamily: "AlloyInk",
                      fontSize: 45.0,
                      color: Colors.white.withOpacity(0.8))),
              Text(
                "Get ready for a colorful adventure! Pop as many balloons as you can, and see if you can beat the high score!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 16.0),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
        Positioned(
          bottom: -30,
          child: GestureDetector(
            onTap: onNextPressed,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(66, 1, 1, 1),
                        spreadRadius: 5,
                        blurRadius: 5)
                  ],
                  color: const Color.fromARGB(255, 223, 223, 223),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 32.5,
                color: KColors.primary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
