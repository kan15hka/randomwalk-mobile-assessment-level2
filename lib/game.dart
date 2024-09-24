import 'dart:async';
import 'dart:math';

import 'package:balloon_pop/colors.dart';
import 'package:balloon_pop/constants.dart';
import 'package:balloon_pop/helper.dart';
import 'package:balloon_pop/info.dart';
import 'package:balloon_pop/model/balloon_model.dart';
import 'package:balloon_pop/widgets/game_header.dart';
import 'package:balloon_pop/widgets/game_stat_widgets.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;
  int balloonsMissed = 0;
  int secondsRemaining = 120;
  List<Balloon> balloons = [];
  Random random = Random();
  Timer? timer;
  Timer? balloonTimer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          if (secondsRemaining > 0) {
            secondsRemaining--;
          } else {
            endGame();
          }
        });
      }
    });

    balloonTimer = Timer.periodic(Duration(milliseconds: 15), (timer) {
      if (!isPaused) {
        setState(() {
          if (balloons.length < 5) {
            addBalloon();
          }
          moveBalloons();
        });
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void resetGame() {
    setState(() {
      score = 0;
      balloonsMissed = 0;
      secondsRemaining = 120;
      balloons.clear();
      isPaused = false;
    });
    timer?.cancel();
    balloonTimer?.cancel();
    startGame();
  }

  void addBalloon() {
    double size = random.nextDouble() * 50 + 100;
    int randomIndex = random.nextInt(KConstants.balloonsImg.length);
    balloons.add(Balloon(
      balloon: KConstants.balloonsImg[randomIndex],
      color: KColors.balloonsColor[randomIndex],
      isPoppedVal: 1,
      x: random.nextDouble() * (MediaQuery.of(context).size.width - size),
      y: MediaQuery.of(context).size.height,
      size: size,
      speed: random.nextDouble() * 2 + 1,
    ));
  }

  void moveBalloons() {
    for (int i = balloons.length - 1; i >= 0; i--) {
      balloons[i].y -= balloons[i].speed;
      if (balloons[i].y + balloons[i].size < 0) {
        balloons.removeAt(i);
        setState(() {
          score--;
          balloonsMissed++;
        });
      }
    }
  }

  void popBalloon(int index) {
    if (index >= balloons.length || balloons[index].isPoppedVal != 1)
      return; // Prevent out-of-bounds access and double-popping

    setState(() {
      balloons[index].isPoppedVal = 0; // Start popping animation
      score += 2;
    });

    // Use Timer instead of Future.delayed
    Timer(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          balloons.removeWhere((balloon) => balloon.isPoppedVal == 0);
        });
      }
    });
  }

  void endGame() {
    timer?.cancel();
    balloonTimer?.cancel();
    KHelper().showGameOverDialog(context, score, () {
      Navigator.of(context).pop();
      resetGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            //Header
            KGameScreenHeader(
              onInfoTapped: () {
                togglePause();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoScreen()));
                togglePause();
              },
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GameStatCard(text: 'Score: $score'),
                GameStatButton(
                    icon: isPaused ? Icons.play_arrow : Icons.pause,
                    onTap: togglePause),
                GameStatButton(icon: Icons.refresh, onTap: resetGame),
                GameStatCard(
                    text:
                        'Time: ${secondsRemaining ~/ 60}:${(secondsRemaining % 60).toString().padLeft(2, '0')}'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                child: Stack(
                  children: [
                    // Background
                    Container(color: KColors.secondary),

                    // Balloons
                    isPaused
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Game Paused",
                                  style: TextStyle(
                                      fontSize: 18.0, color: KColors.primary)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45.0),
                                child: Text(
                                    "Tap the play button to jump back into the action!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            KColors.primary.withOpacity(0.5))),
                              ),
                            ],
                          ))
                        : Stack(
                            children: balloons.asMap().entries.map((balloon) {
                              return Positioned(
                                left: balloon.value.x,
                                top: balloon.value.y,
                                child: GestureDetector(
                                  onTap: () => popBalloon(balloon.key),
                                  child: Container(
                                    width: balloon.value.size,
                                    height: balloon.value.size,
                                    decoration: BoxDecoration(),
                                    child: (balloon.value.isPoppedVal == 1)
                                        ? Image.asset(balloon.value.balloon)
                                        : (balloon.value.isPoppedVal == 0)
                                            ? Image.asset(
                                                KConstants.burst,
                                                color: balloon.value.color,
                                              )
                                            : null,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                    // UI Elements
                    SafeArea(
                      child: Container(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              color: KColors.primary.withOpacity(0.2),
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Missed: $balloonsMissed',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: KColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    balloonTimer?.cancel();
    super.dispose();
  }
}
