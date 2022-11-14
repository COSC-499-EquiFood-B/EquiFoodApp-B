import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'collection_struct.g.dart';

abstract class CollectionStruct
    implements Built<CollectionStruct, CollectionStructBuilder> {
  static Serializer<CollectionStruct> get serializer =>
      _$collectionStructSerializer;

  String? get photo;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(CollectionStructBuilder builder) => builder
    ..photo = ''
    ..firestoreUtilData = FirestoreUtilData();

  CollectionStruct._();
  factory CollectionStruct([void Function(CollectionStructBuilder) updates]) =
      _$CollectionStruct;
}

CollectionStruct createCollectionStruct({
  String? photo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CollectionStruct(
      (c) => c
        ..photo = photo
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

CollectionStruct? updateCollectionStruct(
  CollectionStruct? collection, {
  bool clearUnsetFields = true,
}) =>
    collection != null
        ? (collection.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addCollectionStructData(
  Map<String, dynamic> firestoreData,
  CollectionStruct? collection,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (collection == null) {
    return;
  }
  if (collection.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && collection.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final collectionData = getCollectionFirestoreData(collection, forFieldValue);
  final nestedData = collectionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = collection.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getCollectionFirestoreData(
  CollectionStruct? collection, [
  bool forFieldValue = false,
]) {
  if (collection == null) {
    return {};
  }
  final firestoreData =
      serializers.toFirestore(CollectionStruct.serializer, collection);

  // Add any Firestore field values
  collection.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCollectionListFirestoreData(
  List<CollectionStruct>? collections,
) =>
    collections?.map((c) => getCollectionFirestoreData(c, true)).toList() ?? [];
