//Packages
import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
//Project
import '../../../shared/url.dart';
import '../../domain/entity/user.dart';
import '../model/user_model.dart';


abstract class GetUserDatasource {
  Future<User?> getUser(String token);

}

@Injectable(singleton: false)
class GetUserDatasourceImpl implements GetUserDatasource {

  @override
  Future<User> getUser(String username) async {


    Uri url = Uri.parse(searchUser + username);
    Response result = await http.get(url);
    print(result.statusCode);
    print(result.body);
    if (result.statusCode == 200) {
      var json = result.body;
      User user = UserModel.fromJson(jsonDecode(json));
      return user;
    } else {
      throw Exception();
    }
  }
}
