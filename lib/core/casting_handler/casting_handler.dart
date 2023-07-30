import '../errors/exceptions.dart';

CastingErrorException? castingHandler({required Map<String, dynamic> request,required  String className, List<String> exclude = const []}) {
  final listKey = <String>[];
  for (MapEntry value in request.entries) {
    // print('listKey $className: ${value.key} ${value.value}');
    if (value.value == null && !(exclude.contains(value.key))) {
      listKey.add(value.key);
    }
  }

  if (listKey.isNotEmpty) {
    return CastingErrorException(className: className, listCasting: listKey);
  }

  return null;
}