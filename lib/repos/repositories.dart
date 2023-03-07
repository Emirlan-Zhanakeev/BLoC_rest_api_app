import 'dart:convert';
// ignore_for_file: avoid_print
import 'package:bloc_rest_api/model/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  String endpoint = 'https://jsonplaceholder.typicode.com/users';
  Future<List<UserModel>> getData() async {
    Response response = await get(Uri.parse(endpoint));
    if(response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      print('Get request!');
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

///гет запрос используя конструс