import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tenis/app/data/provider/schedule_controller.dart';
import 'package:tenis/app/modules/schedule/schedule_page.dart';
import 'local_widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Reservaciones'),
        actions: [
          Column(children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/schedule');
                },
                icon: Icon(Icons.add))
          ])
        ],
      ),
      body: Container(
        color: Colors.white24,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Sus reservaciones.',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.canchaList.length,
                  itemBuilder: (context, index) {
                    final data = provider.canchaList[index];
                    return CardWidgets(
                      data: data,
                      provider: provider,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
