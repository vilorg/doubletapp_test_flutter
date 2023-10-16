// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habbit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabbitModelAdapter extends TypeAdapter<HabbitModel> {
  @override
  final int typeId = 0;

  @override
  HabbitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabbitModel(
      title: fields[0] as String,
      description: fields[1] as String,
      priority: fields[2] as Priorety,
      type: fields[3] as TypeHabbit,
      count: fields[4] as int,
      date: fields[5] as int,
      doneDates: (fields[6] as List).cast<int>(),
      frequency: fields[7] as int,
      uid: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HabbitModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.doneDates)
      ..writeByte(7)
      ..write(obj.frequency)
      ..writeByte(8)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabbitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PrioretyAdapter extends TypeAdapter<Priorety> {
  @override
  final int typeId = 1;

  @override
  Priorety read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priorety.low;
      case 1:
        return Priorety.medium;
      case 2:
        return Priorety.high;
      default:
        return Priorety.low;
    }
  }

  @override
  void write(BinaryWriter writer, Priorety obj) {
    switch (obj) {
      case Priorety.low:
        writer.writeByte(0);
        break;
      case Priorety.medium:
        writer.writeByte(1);
        break;
      case Priorety.high:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrioretyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeHabbitAdapter extends TypeAdapter<TypeHabbit> {
  @override
  final int typeId = 2;

  @override
  TypeHabbit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeHabbit.bad;
      case 1:
        return TypeHabbit.good;
      default:
        return TypeHabbit.bad;
    }
  }

  @override
  void write(BinaryWriter writer, TypeHabbit obj) {
    switch (obj) {
      case TypeHabbit.bad:
        writer.writeByte(0);
        break;
      case TypeHabbit.good:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeHabbitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
