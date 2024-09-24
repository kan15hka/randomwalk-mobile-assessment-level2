import 'package:balloon_pop/colors.dart';
import 'package:balloon_pop/widgets/game_stat_widgets.dart';
import 'package:flutter/material.dart';

class KHelper {
  void showGameOverDialog(
      BuildContext context, int score, VoidCallback restartGame) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: KColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Game Over",
                    style: TextStyle(
                        fontFamily: "AlloyInk",
                        fontSize: 30.0,
                        color: Colors.white.withOpacity(0.95))),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Final Score: $score',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GameStatCard(text: "Restart", onTap: restartGame),
                    GameStatCard(
                      text: "Quit",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
