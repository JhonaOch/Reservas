import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tenis/app/data/models/cancha_model.dart';
import 'package:tenis/app/data/provider/schedule_controller.dart';
import 'package:tenis/app/data/provider/welcome_controller.dart';
import 'package:tenis/app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CanchaModelAdapter());
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WelcomeController()),
        ChangeNotifierProvider(create: (_) => ScheduleController()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reservacion de cancha',
          initialRoute: '/welcome',
          routes: appRoutes),
    );
  }
}
