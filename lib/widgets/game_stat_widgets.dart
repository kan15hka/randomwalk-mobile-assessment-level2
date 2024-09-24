import 'package:flutter/material.dart';

class GameStatButton extends StatelessWidget {
  GameStatButton({super.key, required this.icon, this.onTap});
  IconData icon;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //color: Colors.red,
        padding: EdgeInsets.all(7.5),
        child: Icon(
          icon,
          size: 25.0,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }
}

class GameStatCard extends StatelessWidget {
  GameStatCard({super.key, required this.text, this.onTap});

  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(7.5),
            border: Border.all(color: Colors.white.withOpacity(0.25))),
        child: SizedBox(
          width: width * 0.25,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 17, color: Colors.white.withOpacity(0.75)),
          ),
        ),
      ),
    );
  }
}

class KCircularButton extends StatelessWidget {
  KCircularButton({super.key, this.onTap, required this.icon});
  VoidCallback? onTap;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
        child: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
