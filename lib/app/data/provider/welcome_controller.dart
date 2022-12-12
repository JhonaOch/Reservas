import 'package:flutter/material.dart';

class WelcomeController extends ChangeNotifier {
  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  void navigation() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}
