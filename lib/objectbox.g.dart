// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'Models/alerts.dart';
import 'Models/history.dart';
import 'Models/is_trade_active.dart';
import 'Models/wishlist.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5374050143125201716),
      name: 'AlertModel',
      lastPropertyId: const IdUid(2, 5139198172485592952),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6784202001058095764),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5139198172485592952),
            name: 'notification',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 5554440791448569413),
      name: 'HistoryModel',
      lastPropertyId: const IdUid(3, 5300410434736649829),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8831598997196101207),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4984334277308907384),
            name: 'productId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5300410434736649829),
            name: 'productCategory',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 5195633494914985286),
      name: 'WishlistModel',
      lastPropertyId: const IdUid(3, 9077593207092530684),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6797495402530983036),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3568363044888145450),
            name: 'productId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 9077593207092530684),
            name: 'productCategory',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 2630773087187223940),
      name: 'ActiveTradeModel',
      lastPropertyId: const IdUid(3, 9072985614268647155),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 538406362511150529),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8882382837284486161),
            name: 'productId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 9072985614268647155),
            name: 'productCategory',
            type: 9,
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
      lastEntityId: const IdUid(4, 2630773087187223940),
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
    AlertModel: EntityDefinition<AlertModel>(
        model: _entities[0],
        toOneRelations: (AlertModel object) => [],
        toManyRelations: (AlertModel object) => {},
        getId: (AlertModel object) => object.id,
        setId: (AlertModel object, int id) {
          object.id = id;
        },
        objectToFB: (AlertModel object, fb.Builder fbb) {
          final notificationOffset = fbb.writeString(object.notification);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, notificationOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = AlertModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              notification: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''));

          return object;
        }),
    HistoryModel: EntityDefinition<HistoryModel>(
        model: _entities[1],
        toOneRelations: (HistoryModel object) => [],
        toManyRelations: (HistoryModel object) => {},
        getId: (HistoryModel object) => object.id,
        setId: (HistoryModel object, int id) {
          object.id = id;
        },
        objectToFB: (HistoryModel object, fb.Builder fbb) {
          final productIdOffset = fbb.writeString(object.productId);
          final productCategoryOffset = fbb.writeString(object.productCategory);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, productIdOffset);
          fbb.addOffset(2, productCategoryOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = HistoryModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              productId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              productCategory: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    WishlistModel: EntityDefinition<WishlistModel>(
        model: _entities[2],
        toOneRelations: (WishlistModel object) => [],
        toManyRelations: (WishlistModel object) => {},
        getId: (WishlistModel object) => object.id,
        setId: (WishlistModel object, int id) {
          object.id = id;
        },
        objectToFB: (WishlistModel object, fb.Builder fbb) {
          final productIdOffset = fbb.writeString(object.productId);
          final productCategoryOffset = fbb.writeString(object.productCategory);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, productIdOffset);
          fbb.addOffset(2, productCategoryOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = WishlistModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              productId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              productCategory: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    ActiveTradeModel: EntityDefinition<ActiveTradeModel>(
        model: _entities[3],
        toOneRelations: (ActiveTradeModel object) => [],
        toManyRelations: (ActiveTradeModel object) => {},
        getId: (ActiveTradeModel object) => object.id,
        setId: (ActiveTradeModel object, int id) {
          object.id = id;
        },
        objectToFB: (ActiveTradeModel object, fb.Builder fbb) {
          final productIdOffset = fbb.writeString(object.productId);
          final productCategoryOffset = fbb.writeString(object.productCategory);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, productIdOffset);
          fbb.addOffset(2, productCategoryOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ActiveTradeModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              productId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              productCategory: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [AlertModel] entity fields to define ObjectBox queries.
class AlertModel_ {
  /// see [AlertModel.id]
  static final id =
      QueryIntegerProperty<AlertModel>(_entities[0].properties[0]);

  /// see [AlertModel.notification]
  static final notification =
      QueryStringProperty<AlertModel>(_entities[0].properties[1]);
}

/// [HistoryModel] entity fields to define ObjectBox queries.
class HistoryModel_ {
  /// see [HistoryModel.id]
  static final id =
      QueryIntegerProperty<HistoryModel>(_entities[1].properties[0]);

  /// see [HistoryModel.productId]
  static final productId =
      QueryStringProperty<HistoryModel>(_entities[1].properties[1]);

  /// see [HistoryModel.productCategory]
  static final productCategory =
      QueryStringProperty<HistoryModel>(_entities[1].properties[2]);
}

/// [WishlistModel] entity fields to define ObjectBox queries.
class WishlistModel_ {
  /// see [WishlistModel.id]
  static final id =
      QueryIntegerProperty<WishlistModel>(_entities[2].properties[0]);

  /// see [WishlistModel.productId]
  static final productId =
      QueryStringProperty<WishlistModel>(_entities[2].properties[1]);

  /// see [WishlistModel.productCategory]
  static final productCategory =
      QueryStringProperty<WishlistModel>(_entities[2].properties[2]);
}

/// [ActiveTradeModel] entity fields to define ObjectBox queries.
class ActiveTradeModel_ {
  /// see [ActiveTradeModel.id]
  static final id =
      QueryIntegerProperty<ActiveTradeModel>(_entities[3].properties[0]);

  /// see [ActiveTradeModel.productId]
  static final productId =
      QueryStringProperty<ActiveTradeModel>(_entities[3].properties[1]);

  /// see [ActiveTradeModel.productCategory]
  static final productCategory =
      QueryStringProperty<ActiveTradeModel>(_entities[3].properties[2]);
}
