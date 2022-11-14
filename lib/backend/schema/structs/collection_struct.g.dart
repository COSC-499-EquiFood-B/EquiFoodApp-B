// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionStruct> _$collectionStructSerializer =
    new _$CollectionStructSerializer();

class _$CollectionStructSerializer
    implements StructuredSerializer<CollectionStruct> {
  @override
  final Iterable<Type> types = const [CollectionStruct, _$CollectionStruct];
  @override
  final String wireName = 'CollectionStruct';

  @override
  Iterable<Object?> serialize(Serializers serializers, CollectionStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.photo;
    if (value != null) {
      result
        ..add('photo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  CollectionStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'photo':
          result.photo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'firestoreUtilData':
          result.firestoreUtilData = serializers.deserialize(value,
                  specifiedType: const FullType(FirestoreUtilData))!
              as FirestoreUtilData;
          break;
      }
    }

    return result.build();
  }
}

class _$CollectionStruct extends CollectionStruct {
  @override
  final String? photo;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$CollectionStruct(
          [void Function(CollectionStructBuilder)? updates]) =>
      (new CollectionStructBuilder()..update(updates))._build();

  _$CollectionStruct._({this.photo, required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'CollectionStruct', 'firestoreUtilData');
  }

  @override
  CollectionStruct rebuild(void Function(CollectionStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionStructBuilder toBuilder() =>
      new CollectionStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionStruct &&
        photo == other.photo &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, photo.hashCode), firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CollectionStruct')
          ..add('photo', photo)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class CollectionStructBuilder
    implements Builder<CollectionStruct, CollectionStructBuilder> {
  _$CollectionStruct? _$v;

  String? _photo;
  String? get photo => _$this._photo;
  set photo(String? photo) => _$this._photo = photo;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  CollectionStructBuilder() {
    CollectionStruct._initializeBuilder(this);
  }

  CollectionStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _photo = $v.photo;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CollectionStruct;
  }

  @override
  void update(void Function(CollectionStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CollectionStruct build() => _build();

  _$CollectionStruct _build() {
    final _$result = _$v ??
        new _$CollectionStruct._(
            photo: photo,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData, r'CollectionStruct', 'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
