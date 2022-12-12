import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:tenis/app/data/models/cancha_model.dart';
import 'package:tenis/app/data/models/clima_response.dart';
import 'package:tenis/app/data/services/clima_service.dart';
import 'package:tenis/app/global_widgets/snackbar.dart';

class ScheduleController with ChangeNotifier {
  final List<CanchaModel> _canchaList = [];
  ClimaService ser = ClimaService();
  final bool _loading = false;
  final _myBox = Hive.box('mybox');

  dynamic _currentTime;
  dynamic _currentSelectedDate;
  dynamic _clima = '';

  //GET -SET
  get canchaList => _canchaList;
  get currentTime => _currentTime;
  get currentSelectedDate => _currentSelectedDate;
  get clima => _clima;
  get loading => _loading;

  ScheduleController() {
    cargarData();
  }

  Future<bool> addReservacion(String nombre, String cancha, String? fecha,
      String? hora, String clima, context) async {
    print('$nombre ,$cancha,$fecha,$hora,$clima');
    if (nombre.isNotEmpty &&
        cancha.isNotEmpty &&
        fecha!.isNotEmpty &&
        hora!.isNotEmpty &&
        clima.isNotEmpty) {
      _currentSelectedDate = null;
      _currentTime = null;

      final datoNuevo = CanchaModel(
          nombreCancha: cancha,
          fechaAgendamiento: fecha,
          horaAgendamiento: hora,
          nombreUsuario: nombre,
          clima: clima);

      bool validator = _canchaList.contains(datoNuevo);

      var validarCanchaHora = _canchaList.where((CanchaModel element) {
        if (element.horaAgendamiento == datoNuevo.horaAgendamiento &&
            element.nombreCancha == datoNuevo.nombreCancha) {
          return true;
        }
        return false;
      });

      if (validator) {
        MessageNotification.notification(
            context, 'Ya esta reservado', Colors.yellowAccent);
      } else {
        if (validarCanchaHora.isNotEmpty) {
          MessageNotification.notification(
              context, 'Cancha reservada', Colors.yellowAccent);
        } else {
          //TODO Stock
          if (_canchaList.isEmpty) {
            _canchaList.add(datoNuevo);
            _myBox.put('lista', _canchaList);
            Navigator.pushNamed(context, '/home');
          } else {
            int cont = 0;
            for (var da in _canchaList) {
              if (da.fechaAgendamiento == datoNuevo.fechaAgendamiento &&
                  da.nombreCancha == datoNuevo.nombreCancha) {
                cont++;
              }
            }
            if (cont == 3) {
              MessageNotification.notification(
                  context, 'Cancha agotada por dia 3/3', Colors.yellowAccent);
              return false;
            } else {
              _canchaList.add(datoNuevo);
              _myBox.put('lista', _canchaList);
              Navigator.pushNamed(context, '/home');
              return true;
            }
            // _myBox.put('lista', _canchaList);
            // return false;
          }
        }
      }
    } else {
      MessageNotification.notification(
          context, 'Ingrese sus datos', Colors.yellowAccent);
    }
    notifyListeners();

    return true;
  }

  Future getTimePicker(BuildContext context) async {
    _currentTime = TimeOfDay.now();
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _currentTime, //get today's date
    );

    if (time != null) {
      _currentTime = time;
      notifyListeners();
    } else {
      return;
    }
  }

  Future getDatePicker(BuildContext context) async {
    _currentSelectedDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _currentSelectedDate, //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      _currentSelectedDate = formatDate(pickedDate, [yyyy, '-', mm, '-', dd]);
      getClima();
      notifyListeners();
    } else {
      return;
    }
  }

  void cargarData() {
    print('Cargar datos');
    var data = _myBox.get('lista');
    if (data != null) {
      for (var item in data) {
        print('Si hay datos');
        _canchaList.add(item);
        print(canchaList);
        notifyListeners();
      }
    }

    //_canchaList.add(a);
    // _canchaList.add(a);
  }

  void eliminar(CanchaModel canchaModel) {
    if (_canchaList.contains(canchaModel)) {
      _canchaList.remove(canchaModel);
      _myBox.put('lista', _canchaList);
      // cargarData();
      notifyListeners();
    }
  }

  void getClima() async {
    if (_currentSelectedDate != null) {
      final ClimaResponse resp =
          await ser.getClima(_currentSelectedDate.toString());
      final data = resp.data;
      for (var item in data) {
        for (var cor in item.coordinates) {
          for (var cl in cor.dates) {
            _clima = cl.value;
            notifyListeners();
          }
        }
      }
    }
    return;
  }
}
