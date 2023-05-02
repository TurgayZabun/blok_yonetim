// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blok.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlokAdapter extends TypeAdapter<Blok> {
  @override
  final int typeId = 0;

  @override
  Blok read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Blok()
      .._blokAdi = fields[0] as String?
      ..daireler = (fields[1] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Blok obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._blokAdi)
      ..writeByte(1)
      ..write(obj.daireler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlokAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DaireAdapter extends TypeAdapter<Daire> {
  @override
  final int typeId = 1;

  @override
  Daire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Daire(
      daireNo: fields[0] as int,
      bulunduguKat: fields[1] as int,
      bulunduguBlok: fields[2] as String,
    ).._bireyler = (fields[3] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Daire obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.daireNo)
      ..writeByte(1)
      ..write(obj.bulunduguKat)
      ..writeByte(2)
      ..write(obj.bulunduguBlok)
      ..writeByte(3)
      ..write(obj._bireyler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DaireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BireyAdapter extends TypeAdapter<Birey> {
  @override
  final int typeId = 2;

  @override
  Birey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Birey(
      adi: fields[0] as String,
      soyadi: fields[1] as String,
      telefon: fields[2] as String,
      durum: fields[3] as String,
      daire: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Birey obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.adi)
      ..writeByte(1)
      ..write(obj.soyadi)
      ..writeByte(2)
      ..write(obj.telefon)
      ..writeByte(3)
      ..write(obj.durum)
      ..writeByte(4)
      ..write(obj.daire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BireyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
