// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancha_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CanchaModelAdapter extends TypeAdapter<CanchaModel> {
  @override
  final int typeId = 0;

  @override
  CanchaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CanchaModel(
      nombreCancha: fields[0] as String,
      fechaAgendamiento: fields[1] as String,
      horaAgendamiento: fields[3] as String,
      nombreUsuario: fields[2] as String,
      clima: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CanchaModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nombreCancha)
      ..writeByte(1)
      ..write(obj.fechaAgendamiento)
      ..writeByte(2)
      ..write(obj.nombreUsuario)
      ..writeByte(3)
      ..write(obj.horaAgendamiento)
      ..writeByte(4)
      ..write(obj.clima);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CanchaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
