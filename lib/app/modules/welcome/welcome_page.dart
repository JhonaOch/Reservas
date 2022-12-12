import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenis/app/global_widgets/button_app.dart';
import 'package:tenis/app/data/provider/welcome_controller.dart';
import 'package:tenis/app/modules/home/home_page.dart.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final WelcomeController _con = WelcomeController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Future.delayed(
        const Duration(seconds: 4),
        () {
          Get.off(() => const HomePage(),
              transition: Transition.native,
              duration: const Duration(seconds: 4));
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.orange.shade300,
          borderRadius: BorderRadius.circular(300)),
      child: Column(
        children: [
          Image.asset('assets/img/tennis-logo.jpg'),
          const Spacer(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: LinearProgressIndicator(
                    color: Colors.yellow,
                    minHeight: 30,
                    backgroundColor: Colors.orange,
                  ))),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    ));
  }
}
