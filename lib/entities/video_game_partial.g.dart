// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_game_partial.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoGamePartialAdapter extends TypeAdapter<VideoGamePartial> {
  @override
  final int typeId = 0;

  @override
  VideoGamePartial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoGamePartial(
      id: fields[0] as int,
      name: fields[1] as String,
      coverUrl: fields[2] as String,
      firstReleaseDate: fields[3] as int,
      releaseDate: fields[4] as DateTime,
      rating: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, VideoGamePartial obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coverUrl)
      ..writeByte(3)
      ..write(obj.firstReleaseDate)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoGamePartialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
