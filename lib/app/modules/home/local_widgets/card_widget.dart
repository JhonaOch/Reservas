import 'package:flutter/material.dart';
import 'package:tenis/app/data/models/cancha_model.dart';
import 'package:tenis/app/global_widgets/button_app.dart';
import 'package:tenis/app/data/provider/schedule_controller.dart';

class CardWidgets extends StatelessWidget {
  final CanchaModel data;
  final ScheduleController provider;
  const CardWidgets({Key? key, required this.data, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 30,
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Reservación',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.sports_tennis, size: 100),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textStyle("Usuario: ${data.nombreUsuario}"),
                        textStyle("Cancha: ${data.nombreCancha}"),
                        textStyle("Fecha: ${data.fechaAgendamiento}"),
                        textStyle("Hora: ${data.horaAgendamiento}"),
                        textStyle("Lluvia: ${data.clima} % "),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 100,
            child: ButtonApp(
                colorText: Colors.black,
                heigth: 40,
                color: Colors.red.shade300,
                text: 'Borrar',
                onPress: () {
                  alertConfirm(provider, data, context);

                  //provider.eliminar(data);
                }),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget textStyle(String valor) {
    return Text(valor,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ));
  }

  alertConfirm(
      ScheduleController provider, CanchaModel data, BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agendamiento'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Desea borrar su agendamiento.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                provider.eliminar(data);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
