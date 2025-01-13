//Packages
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
//Project
import '../../../shared/errors.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/get_user_repository.dart';
import '../datasource/get_user_datasource.dart';



@Injectable(singleton: false)
class GetUserRepositoryImpl implements GetUserRepository {
  final GetUserDatasource datasource;

  GetUserRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, User>> getUser(String username) async {
    User? userModel;

    try {
      userModel = await datasource.getUser(username);
    } catch (e) {
      print(e);
      return left(Failure());
    }
    print(userModel);
    return userModel == null ? left(Failure()) : right(userModel);
  }

}