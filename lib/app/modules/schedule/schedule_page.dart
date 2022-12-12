import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis/app/global_widgets/button_app.dart';
import 'package:tenis/app/global_widgets/snackbar.dart';
import 'package:tenis/app/data/provider/schedule_controller.dart';

class SchedulePage extends StatefulWidget {
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String _nombre = '';
  String _opcionselecionado = '';
  final List<String> _listaCanchas = ['A', 'B', 'C'];
  final ScheduleController _con = ScheduleController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Agendar'),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            inputPerson(),
            const SizedBox(
              height: 20,
            ),
            inputCancha(),
            const SizedBox(
              height: 20,
            ),
            inputDate(provider),
            const SizedBox(
              height: 20,
            ),
            inputLluvia(provider),
            const SizedBox(
              height: 20,
            ),
            inputClock(provider),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'DATOS INGRESADOS:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            result(provider),
          ],
        ),
      ),
    );
  }

  //Widgets

  Widget result(ScheduleController provider) {
    return Card(
      color: Colors.orange.shade200,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          _nombre.isEmpty
              ? const Text(
                  "Nombre: 'Usuario' ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Text(
                  "Nombre:${_nombre.trim()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
          _opcionselecionado.isEmpty
              ? const Text(
                  "Cancha: 'A-B-C' ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Text(
                  'Cancha: $_opcionselecionado',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
          provider.currentSelectedDate == null
              ? const Text(
                  "Fecha: 'aaaa/mm/dd' ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Text(
                  'Fecha: ${provider.currentSelectedDate}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
          provider.currentTime == null
              ? const Text(
                  "Hora: '00:00' ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Text(
                  'Hora:  ${provider.currentTime.format(context)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

          provider.clima == null
              ? const Text(
                  "Lluvia:'lluvia %' ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Text(
                  'Lluvia: ${provider.clima} %',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

          // const Text('Clima:  30%'),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100),
            child: ButtonApp(
              onPress: () {
                final res = provider.addReservacion(
                    _nombre,
                    _opcionselecionado,
                    provider.currentSelectedDate.toString(),
                    provider.currentTime == null
                        ? ''
                        : provider.currentTime.format(context).toString(),
                    provider.clima.toString(),
                    context);

                if (res == true) {
                  limpiar();
                }
              },
              text: 'Agendar',
              color: Colors.blueAccent,
              colorText: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget inputPerson() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.centerLeft,
      child: TextFormField(
          onChanged: (value) {
            setState(() {
              _nombre = value;
            });
          },
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            hintText: 'Ingrese el nombre del usuario',
            suffixIcon: Icon(
              Icons.person,
              color: Colors.black,
            ),
          )),
    );
  }

  Widget inputCancha() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.orange,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seleccione su cancha:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 20,
            ),
            DropdownButton(
                hint: Text(_opcionselecionado),
                items: _listaCanchas.map((e) {
                  return DropdownMenuItem(
                      value: e ?? (e = e),
                      child: Text(
                        e.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _opcionselecionado = value.toString();
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget inputDate(ScheduleController provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ButtonApp(
            onPress: () {
              provider.getDatePicker(context);
            },
            text: 'Seleccione la fecha:',
            heigth: 45,
            color: Colors.orange,
            colorText: Colors.black,
            fontSize: 20,
          ),
          provider.currentSelectedDate == null
              ? const Text(
                  "'aaaa/mm/dd' ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              : Text(
                  '${provider.currentSelectedDate}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }

  Widget inputLluvia(ScheduleController provider) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                height: 45,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Probabilidad de lluvia:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ])),
            SizedBox(
              width: 5,
            ),
            provider.clima == null
                ? const Text(
                    "'lluvia %' ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${provider.clima} %',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ],
        ));
  }

  Widget inputClock(ScheduleController provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ButtonApp(
            onPress: () {
              provider.getTimePicker(context);
            },
            text: 'Seleccione su horario:',
            heigth: 45,
            color: Colors.orange,
            colorText: Colors.black,
            fontSize: 20,
          ),
          provider.currentTime == null
              ? const Text(
                  "00:00 HH",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              : Text(
                  '${provider.currentTime.format(context)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }

  void limpiar() {
    setState(() {
      _nombre = '';
      _opcionselecionado = '';
    });
  }
}
