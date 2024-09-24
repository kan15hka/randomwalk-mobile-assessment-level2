import 'package:flutter/material.dart';

class Balloon {
  int isPoppedVal;
  double x;
  double y;
  double size;
  double speed;
  String balloon;
  Color color;

  Balloon(
      {required this.balloon,
      required this.color,
      required this.isPoppedVal,
      required this.x,
      required this.y,
      required this.size,
      required this.speed});
}
