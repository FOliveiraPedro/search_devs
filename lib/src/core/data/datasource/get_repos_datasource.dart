//Packages
import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//Project
import '../../../shared/url.dart';
import '../../domain/entity/repo.dart';
import '../../domain/entity/user.dart';
import '../model/repo_model.dart';
import '../model/user_model.dart';

abstract class GetReposDatasource {
  Future<List<Repo>?> getRepos(String token, int page);
}

@Injectable(singleton: false)
class GetReposDatasourceImpl implements GetReposDatasource {
  @override
  Future<List<Repo>> getRepos(String username,int page) async {
    Uri url = Uri.parse("$searchUser$username/repos?per_page=10&page=$page");
    Response result = await http.get(url);
    print(result.statusCode);
    print(result.body);
    if (result.statusCode == 200) {
      var json = result.body;
      List list = jsonDecode(json)
          .map((value) => RepoModel.fromJson(value)).toList();
      List<Repo> repoList = [];
      for( var item in list){
        repoList.add(item);
      }
      return repoList;
    } else {
      throw Exception();
    }
  }
}
