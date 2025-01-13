//Packages
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

//Project
import '../../../shared/errors.dart';
import '../entity/user.dart';
import '../repository/get_user_repository.dart';

abstract class GetUserUsecase {
  Future<Either<Failure, User>> call(String token);
}

@Injectable(singleton: false)
class GetUserUsecaseImpl implements GetUserUsecase {
  final GetUserRepository getUserRepository;

  GetUserUsecaseImpl(this.getUserRepository);

  @override
  Future<Either<Failure, User>> call(String username) async {
    var result = await getUserRepository.getUser(username);
    return result;
  }
}