import '../errors/exceptions.dart';
import 'casting_handle_type_model.dart';
/*
  final checkCastingFromModel = castingHandler(
    className: 'ProductAttributes',
    request: json,
    castingHandle: [
      CastingHandleTypeModel("name", TypeCastingCollection.string),
      CastingHandleTypeModel("description", TypeCastingCollection.string),
      CastingHandleTypeModel("quantity", TypeCastingCollection.int),
      CastingHandleTypeModel("price", TypeCastingCollection.int),
      CastingHandleTypeModel("inStock", TypeCastingCollection.bool),
      CastingHandleTypeModel("distributor", TypeCastingCollection.string),
    ]
  );
*/
CastingErrorException? castingHandler({
  required Map<String, dynamic> request,
  required String className,
  List<String> exclude = const [],
  List<CastingHandleTypeModel> castingHandle = const [],
}) {
  final listKey = <String>[];
  final castingHandleToMap = castingHandle.toMap;
  for (MapEntry value in request.entries) {
    if (value.value == null && !(exclude.contains(value.key))) {
      listKey.add(value.key);
    }

    final checkType = castingHandleToMap[value.key];
    if ( checkType != null && !(checkType.checkCastingHandleType(value.value))) {
      listKey.add("Nilai pada ${value.key}(${value.value}) Seharusnya dalam ${checkType.valueString}");
    }
  }

  if (listKey.isNotEmpty) {
    return CastingErrorException(className: className, listCasting: listKey);
  }

  return null;
}
