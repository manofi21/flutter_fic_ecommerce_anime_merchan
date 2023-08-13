enum TypeCastingCollection { 
  string('String'), bool('bool'), double('double'), int('int');
  final String valueString;
  const TypeCastingCollection(this.valueString);
}

class CastingHandleTypeModel {
  final String keyMap;
  final TypeCastingCollection castingType;

  CastingHandleTypeModel(this.keyMap, this.castingType);
}

extension HandleTypeCollection on TypeCastingCollection {
  bool checkCastingHandleType(dynamic value) {
    switch (this) {
      case TypeCastingCollection.string:
        return value is String;
      case TypeCastingCollection.bool:
        return value is bool;
      case TypeCastingCollection.double:
        return value is double;
      case TypeCastingCollection.int:
        return value is int;
      default:
        return false;
    }
  }
}

extension ListCastingHandleTypeModel on List<CastingHandleTypeModel> {
  Map<String, TypeCastingCollection> get toMap {
    final returnMaps = <String, TypeCastingCollection>{};
    for (final sValue in this) {
      returnMaps[sValue.keyMap] = sValue.castingType;
    }
    return returnMaps;
  }
}