import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final Color color;
  final Color colorText;
  final double heigth;
  final double fontSize;
  final double border;
  final String text;
  final Function() onPress;
  final IconData icon;

  const ButtonApp({
    super.key,
    required this.color,
    this.fontSize = 15.0,
    this.heigth = 50,
    this.border = 18.0,
    this.colorText = Colors.white,
    required this.text,
    required this.onPress,
    this.icon = Icons.arrow_forward_ios_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MaterialButton(
          height: heigth,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border),
          ),
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: TextStyle(color: colorText, fontSize: fontSize),
              ),
            ],
          )),
    );
  }
}
