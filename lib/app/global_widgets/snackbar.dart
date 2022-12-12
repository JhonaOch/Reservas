import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class MessageNotification {
  static void notification(
      BuildContext context, String text, Color color) async {
    FocusScope.of(context).unfocus();
    await AnimatedSnackBar(
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color ?? Colors.black),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            height: 30,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }).show(context);
  }
}
