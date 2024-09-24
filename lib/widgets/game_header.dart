import 'package:balloon_pop/game.dart';
import 'package:balloon_pop/info.dart';
import 'package:balloon_pop/widgets/game_stat_widgets.dart';
import 'package:flutter/material.dart';

class KGameScreenHeader extends StatelessWidget {
  KGameScreenHeader({super.key, required this.onInfoTapped});
  VoidCallback onInfoTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KCircularButton(
            icon: Icons.keyboard_arrow_left,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text("Pop'nPlay",
              style: TextStyle(
                  fontFamily: "AlloyInk",
                  fontSize: 30.0,
                  color: Colors.white.withOpacity(0.95))),
          KCircularButton(icon: Icons.info_outline, onTap: onInfoTapped),
        ],
      ),
    );
  }
}
