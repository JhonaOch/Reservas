import 'package:flutter/material.dart';
import 'package:tenis/app/modules/home/home_page.dart.dart';
import 'package:tenis/app/modules/schedule/schedule_page.dart';
import 'package:tenis/app/modules/welcome/welcome_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/home': (_) => const HomePage(),
  '/welcome': (_) => const WelcomePage(),
  '/schedule': (_) => SchedulePage(),
};
