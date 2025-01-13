//Packages
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
//Project
import '../../../shared/errors.dart';
import '../../domain/entity/repo.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/get_repos_repository.dart';
import '../datasource/get_repos_datasource.dart';
import '../datasource/get_user_datasource.dart';



@Injectable(singleton: false)
class GetReposRepositoryImpl implements GetReposRepository {
  final GetReposDatasource datasource;

  GetReposRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Repo>>> getRepos(String username, int page) async {
    List<Repo>? userModel;

    try {
      userModel = await datasource.getRepos(username, page);
    } catch (e) {
      print(e);
      return left(Failure());
    }
    print(userModel);
    return userModel == null ? left(Failure()) : right(userModel);
  }

}