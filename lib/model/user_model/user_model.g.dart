// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userId: fields[0] as String?,
      profileImage: fields[1] as String?,
      fullname: fields[2] as String?,
      email: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      userHandle: fields[5] as String?,
      createdAt: fields[6] as DateTime?,
      isEmailVerified: fields[8] as bool?,
      bio: fields[7] as String?,
      numberOfPost: fields[11] as num,
      listOfFollowers: (fields[12] as List?)?.cast<dynamic>(),
      listOfFollowing: (fields[13] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.profileImage)
      ..writeByte(2)
      ..write(obj.fullname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.userHandle)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.bio)
      ..writeByte(8)
      ..write(obj.isEmailVerified)
      ..writeByte(11)
      ..write(obj.numberOfPost)
      ..writeByte(12)
      ..write(obj.listOfFollowers)
      ..writeByte(13)
      ..write(obj.listOfFollowing);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
