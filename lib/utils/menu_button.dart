import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuButton extends StatelessWidget {
  MenuButton({
    required this.color,
    required this.text,
    required this.fSize,
    required this.fFamily,
    required this.height,
    required this.width,
    required this.fWeight,
    required this.fColor,
  });

  Color color;
  String text;
  int height;
  int width;
  String fFamily;
  double fSize;
  FontWeight fWeight;
  Color fColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: fFamily,
            fontSize: fSize,
            fontWeight: fWeight,
            color: fColor,
          ),
        ),
      ),
    );
  }
}
