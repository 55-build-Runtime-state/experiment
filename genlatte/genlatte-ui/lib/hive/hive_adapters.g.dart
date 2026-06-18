// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class LatteOrderAdapter extends TypeAdapter<LatteOrder> {
  @override
  final typeId = 0;

  @override
  LatteOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatteOrder(
      id: fields[0] as String?,
      name: fields[1] as String?,
      milk: fields[2] as String?,
      sweetener: fields[3] as String?,
      happyPlace: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LatteOrder obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.milk)
      ..writeByte(3)
      ..write(obj.sweetener)
      ..writeByte(4)
      ..write(obj.happyPlace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LatteOrderMetadataAdapter extends TypeAdapter<LatteOrderMetadata> {
  @override
  final typeId = 1;

  @override
  LatteOrderMetadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatteOrderMetadata(
      id: fields[0] as String?,
      orderNumber: (fields[1] as num?)?.toInt(),
      isNameApproved: fields[2] as bool?,
      isHappyPlaceApproved: fields[3] as bool?,
      happyPlaceModerationReason: fields[4] as String?,
      isImageApproved: fields[5] as bool?,
      imageBatchId: fields[6] as String?,
      imageUrl: fields[7] as String?,
      status: fields[8] == null
          ? LatteOrderStatus.configuring
          : fields[8] as LatteOrderStatus,
      baristaId: fields[11] as String?,
      orderSubmittedTime: fields[9] as DateTime?,
      completionTime: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, LatteOrderMetadata obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderNumber)
      ..writeByte(2)
      ..write(obj.isNameApproved)
      ..writeByte(3)
      ..write(obj.isHappyPlaceApproved)
      ..writeByte(4)
      ..write(obj.happyPlaceModerationReason)
      ..writeByte(5)
      ..write(obj.isImageApproved)
      ..writeByte(6)
      ..write(obj.imageBatchId)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.orderSubmittedTime)
      ..writeByte(10)
      ..write(obj.completionTime)
      ..writeByte(11)
      ..write(obj.baristaId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteOrderMetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LatteOrderStatusAdapter extends TypeAdapter<LatteOrderStatus> {
  @override
  final typeId = 2;

  @override
  LatteOrderStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LatteOrderStatus.configuring;
      case 1:
        return LatteOrderStatus.submitted;
      case 2:
        return LatteOrderStatus.validated;
      case 3:
        return LatteOrderStatus.inProgress;
      case 4:
        return LatteOrderStatus.completed;
      case 5:
        return LatteOrderStatus.archived;
      default:
        return LatteOrderStatus.configuring;
    }
  }

  @override
  void write(BinaryWriter writer, LatteOrderStatus obj) {
    switch (obj) {
      case LatteOrderStatus.configuring:
        writer.writeByte(0);
      case LatteOrderStatus.submitted:
        writer.writeByte(1);
      case LatteOrderStatus.validated:
        writer.writeByte(2);
      case LatteOrderStatus.inProgress:
        writer.writeByte(3);
      case LatteOrderStatus.completed:
        writer.writeByte(4);
      case LatteOrderStatus.archived:
        writer.writeByte(5);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteOrderStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LatteImageBatchAdapter extends TypeAdapter<LatteImageBatch> {
  @override
  final typeId = 3;

  @override
  LatteImageBatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatteImageBatch(
      id: fields[0] as String,
      orderId: fields[1] as String,
      image0: fields[5] as LatteImage?,
      image1: fields[2] as LatteImage?,
      image2: fields[3] as LatteImage?,
      image3: fields[4] as LatteImage?,
      parent: fields[6] as LatteImageBatchParent?,
    );
  }

  @override
  void write(BinaryWriter writer, LatteImageBatch obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.image1)
      ..writeByte(3)
      ..write(obj.image2)
      ..writeByte(4)
      ..write(obj.image3)
      ..writeByte(5)
      ..write(obj.image0)
      ..writeByte(6)
      ..write(obj.parent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteImageBatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LatteImageAdapter extends TypeAdapter<LatteImage> {
  @override
  final typeId = 4;

  @override
  LatteImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatteImage(
      imageUrl: fields[0] as String,
      prompt: fields[1] as String,
      questions: (fields[2] as List?)?.cast<Question>(),
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LatteImage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.prompt)
      ..writeByte(2)
      ..write(obj.questions)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final typeId = 5;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      id: fields[0] as String,
      body: fields[1] as String,
      answer: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BaristaAdapter extends TypeAdapter<Barista> {
  @override
  final typeId = 6;

  @override
  Barista read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Barista(
      username: fields[0] as String,
      persona: fields[1] as BaristaPersona,
      id: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Barista obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.persona)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaristaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LatteAdapter extends TypeAdapter<Latte> {
  @override
  final typeId = 7;

  @override
  Latte read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Latte(
      order: fields[0] as LatteOrder,
      metadata: fields[1] as LatteOrderMetadata,
    );
  }

  @override
  void write(BinaryWriter writer, Latte obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.order)
      ..writeByte(1)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BaristaPersonaAdapter extends TypeAdapter<BaristaPersona> {
  @override
  final typeId = 8;

  @override
  BaristaPersona read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BaristaPersona.blackFemale;
      case 1:
        return BaristaPersona.asianFemale;
      case 2:
        return BaristaPersona.caucasianFemale;
      case 3:
        return BaristaPersona.hispanicFemale;
      case 4:
        return BaristaPersona.indianFemale;
      case 5:
        return BaristaPersona.blackMale;
      case 6:
        return BaristaPersona.asianMale;
      case 7:
        return BaristaPersona.caucasianMale;
      case 8:
        return BaristaPersona.hispanicMale;
      case 9:
        return BaristaPersona.indianMale;
      default:
        return BaristaPersona.blackFemale;
    }
  }

  @override
  void write(BinaryWriter writer, BaristaPersona obj) {
    switch (obj) {
      case BaristaPersona.blackFemale:
        writer.writeByte(0);
      case BaristaPersona.asianFemale:
        writer.writeByte(1);
      case BaristaPersona.caucasianFemale:
        writer.writeByte(2);
      case BaristaPersona.hispanicFemale:
        writer.writeByte(3);
      case BaristaPersona.indianFemale:
        writer.writeByte(4);
      case BaristaPersona.blackMale:
        writer.writeByte(5);
      case BaristaPersona.asianMale:
        writer.writeByte(6);
      case BaristaPersona.caucasianMale:
        writer.writeByte(7);
      case BaristaPersona.hispanicMale:
        writer.writeByte(8);
      case BaristaPersona.indianMale:
        writer.writeByte(9);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaristaPersonaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MachineAdapter extends TypeAdapter<Machine> {
  @override
  final typeId = 9;

  @override
  Machine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Machine(
      id: fields[0] as String,
      name: fields[1] as String,
      isActive: fields[3] == null ? true : fields[3] as bool,
      isBlackAndWhite: fields[2] == null ? true : fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Machine obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isBlackAndWhite)
      ..writeByte(3)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
