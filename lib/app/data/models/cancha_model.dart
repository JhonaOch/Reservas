import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part 'cancha_model.g.dart';

CanchaModel canchaModelFromJson(String str) =>
    CanchaModel.fromJson(json.decode(str));

String canchaModelToJson(CanchaModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class CanchaModel extends HiveObject {
  CanchaModel(
      {required this.nombreCancha,
      required this.fechaAgendamiento,
      required this.horaAgendamiento,
      required this.nombreUsuario,
      required this.clima});

  @HiveField(0)
  final String nombreCancha;
  @HiveField(1)
  final String fechaAgendamiento;
  @HiveField(2)
  final String nombreUsuario;
  @HiveField(3)
  final String horaAgendamiento;
  @HiveField(4)
  final String clima;

  factory CanchaModel.fromJson(Map<String, dynamic> json) => CanchaModel(
      nombreCancha: json["nombre_cancha"],
      fechaAgendamiento: json["fecha_agendamiento"],
      nombreUsuario: json["nombre_usuario"],
      horaAgendamiento: json["hora_agendamiento"],
      clima: json["clima"]);

  Map<String, dynamic> toJson() => {
        "nombre_cancha": nombreCancha,
        "fecha_agendamiento": fechaAgendamiento,
        "nombre_usuario": nombreUsuario,
        "hora_agendamiento": horaAgendamiento,
        "clima": clima,
      };
}
