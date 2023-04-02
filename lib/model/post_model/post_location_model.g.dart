// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostLocationModelAdapter extends TypeAdapter<PostLocationModel> {
  @override
  final int typeId = 2;

  @override
  PostLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostLocationModel(
      address: fields[0] as String?,
      lat: fields[1] as num?,
      lng: fields[2] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, PostLocationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
