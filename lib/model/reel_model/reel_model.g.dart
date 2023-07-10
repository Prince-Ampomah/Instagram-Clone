// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReelModelAdapter extends TypeAdapter<ReelModel> {
  @override
  final int typeId = 4;

  @override
  ReelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReelModel(
      id: fields[0] as String?,
      media: fields[2] as String,
      userId: fields[10] as String?,
      caption: fields[1] as String?,
      like: fields[3] as num?,
      comment: fields[4] as num?,
      timePosted: fields[7] as DateTime?,
      isSavedBy: (fields[8] as List?)?.cast<dynamic>(),
      isLikedBy: (fields[9] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReelModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.media)
      ..writeByte(3)
      ..write(obj.like)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(7)
      ..write(obj.timePosted)
      ..writeByte(8)
      ..write(obj.isSavedBy)
      ..writeByte(9)
      ..write(obj.isLikedBy)
      ..writeByte(10)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
