// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'QRCODE/qr_code.dart';
import 'screens/bottom_nav_screen.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 757902020571214150),
      name: 'DeviceModel',
      lastPropertyId: const IdUid(3, 8363002156549262118),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4372525575203765359),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4111455153584405992),
            name: 'deviceId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8363002156549262118),
            name: 'date',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 1085732696181235582),
      name: 'MyQrCode',
      lastPropertyId: const IdUid(5, 3339805549975111916),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6583801831626737087),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6429140376657282869),
            name: 'content',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8733792900545834474),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 786079613745695897),
            name: 'pcr',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3339805549975111916),
            name: 'date',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 1085732696181235582),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    DeviceModel: EntityDefinition<DeviceModel>(
        model: _entities[0],
        toOneRelations: (DeviceModel object) => [],
        toManyRelations: (DeviceModel object) => {},
        getId: (DeviceModel object) => object.id,
        setId: (DeviceModel object, int id) {
          object.id = id;
        },
        objectToFB: (DeviceModel object, fb.Builder fbb) {
          final deviceIdOffset = object.deviceId == null
              ? null
              : fbb.writeString(object.deviceId!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, deviceIdOffset);
          fbb.addInt64(2, object.date.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = DeviceModel(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              const fb.StringReader().vTableGetNullable(buffer, rootOffset, 6))
            ..date = DateTime.fromMillisecondsSinceEpoch(
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0));

          return object;
        }),
    MyQrCode: EntityDefinition<MyQrCode>(
        model: _entities[1],
        toOneRelations: (MyQrCode object) => [],
        toManyRelations: (MyQrCode object) => {},
        getId: (MyQrCode object) => object.id,
        setId: (MyQrCode object, int id) {
          object.id = id;
        },
        objectToFB: (MyQrCode object, fb.Builder fbb) {
          final contentOffset =
              object.content == null ? null : fbb.writeString(object.content!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, contentOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addBool(3, object.pcr);
          fbb.addInt64(4, object.date.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = MyQrCode(
              content: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              pcr: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              date: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0)),
              type: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [DeviceModel] entity fields to define ObjectBox queries.
class DeviceModel_ {
  /// see [DeviceModel.id]
  static final id =
      QueryIntegerProperty<DeviceModel>(_entities[0].properties[0]);

  /// see [DeviceModel.deviceId]
  static final deviceId =
      QueryStringProperty<DeviceModel>(_entities[0].properties[1]);

  /// see [DeviceModel.date]
  static final date =
      QueryIntegerProperty<DeviceModel>(_entities[0].properties[2]);
}

/// [MyQrCode] entity fields to define ObjectBox queries.
class MyQrCode_ {
  /// see [MyQrCode.id]
  static final id = QueryIntegerProperty<MyQrCode>(_entities[1].properties[0]);

  /// see [MyQrCode.content]
  static final content =
      QueryStringProperty<MyQrCode>(_entities[1].properties[1]);

  /// see [MyQrCode.type]
  static final type = QueryStringProperty<MyQrCode>(_entities[1].properties[2]);

  /// see [MyQrCode.pcr]
  static final pcr = QueryBooleanProperty<MyQrCode>(_entities[1].properties[3]);

  /// see [MyQrCode.date]
  static final date =
      QueryIntegerProperty<MyQrCode>(_entities[1].properties[4]);
}
