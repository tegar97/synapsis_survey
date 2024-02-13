import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color background;
  final Function()? onClick;
  final double width;
  double height;

  RoundedButton({
    super.key,
    required this.title,
    required this.style,
    required this.background,
    required this.onClick,
    required this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          title,
          style: style,
        ),
        style: ElevatedButton.styleFrom(
            primary: background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4))),
      ),
    );
  }
}

class RoundedOutlineButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color color;
  final Function()? onClick;
  final double width;

  RoundedOutlineButton({
    super.key,
    required this.title,
    required this.style,
    required this.color,
    required this.onClick,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          title,
          style: style,
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: color, width: 2))),
      ),
    );
  }
}