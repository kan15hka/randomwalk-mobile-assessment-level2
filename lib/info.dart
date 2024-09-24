import 'package:balloon_pop/colors.dart';
import 'package:balloon_pop/widgets/game_stat_widgets.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({super.key});
  List<String> rules = [
    "Pop balloons as they appear to score points (+2 per balloon).",
    "Avoid missing balloons to prevent a penalty (-1 per missed balloon).",
    "You have 2 minutes to pop as many balloons as you can.",
    "Balloons appear randomly from the bottom and move upward.",
    "Your final score is shown at the end—try to beat your high score!",
    "Tap 'Play Again' to restart and improve your score."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.075),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 1.5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Pop'nPlay Rules",
                          style: TextStyle(
                              fontFamily: "AlloyInk",
                              fontSize: 25.0,
                              color: Colors.white.withOpacity(0.8))),
                      Divider(
                        color: Colors.white.withOpacity(0.1),
                      ),
                      ListView.builder(
                          itemCount: rules.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(rules[index],
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                Colors.white.withOpacity(0.5))),
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 15.0,
                  left: 15.0,
                  child: KCircularButton(
                    icon: Icons.keyboard_arrow_left,
                    onTap: () => Navigator.pop(context),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
