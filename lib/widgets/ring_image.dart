import 'package:balloon_pop/constants.dart';
import 'package:flutter/material.dart';

class RingImageWidget extends StatelessWidget {
  RingImageWidget({
    super.key,
  });
  final List<double> ringList = [0.5, 0.75, 1];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.transparent,
                Colors.transparent,
                Colors.white,
              ],
              //set stops as par your requirement
              stops: [0.0, 0.25, 0.75, 1.0], // 50% transparent, 50% white
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ...ringList.map((ringSize) {
                return CircularRing(
                  size: width * ringSize,
                );
              }).toList(),
            ],
          ),
        ),
        Image.asset(
          KConstants.boyImg,
          width: width * 0.9,
        )
      ],
    );
  }
}

class CircularRing extends StatelessWidget {
  const CircularRing({
    super.key,
    required this.size,
    this.color,
  });
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          border: Border.all(
              color: color ?? Colors.white.withOpacity(0.25), width: 2),
          shape: BoxShape.circle),
    );
  }
}
