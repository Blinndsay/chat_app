import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
//Saving your First data object on Back4App
void main() async {
  final keyApplicationId = 'jxwUXeNarR77dJDPnbZTPAgk8r4FHZ7YJXw3CY2h';
  final keyClientKey = 'UFM4E8BoFbyUXkBJFlc2TDEkSbHYKflASbaXMpWi';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
  final objectId = await savePerson();
  final person = await getPerson(objectId);
  print('Person: ${person.toString()}');
  print('Name: ${person['name']}');
  print('Age: ${person['age']}');
}
Future<String> savePerson() async {
  final person = ParseObject('Person')
    ..set('name', "John Snow")
    ..set('age', 27);
  await person.save();
  return person.objectId;
}

//Reading your First Data Object from Back4App
Future<Map<String, dynamic>> getPerson(String objectId) async {
  QueryBuilder<ParseObject> queryPerson =
  QueryBuilder<ParseObject>(ParseObject('Person'))
    ..whereEqualTo('objectId', objectId);
  final ParseResponse apiResponse = await queryPerson.query();
  if (apiResponse.success && apiResponse.results != null) {
    final name = apiResponse.results.first.get<String>('name');
    final age = apiResponse.results.first.get<String>('age');
    return {'name': name, 'age': age};
  } else {
    return {};
  }
}