import 'package:dartz/dartz.dart';

import '../../../shared/errors.dart';
import '../entity/user.dart';

abstract class GetUserRepository{
  Future<Either<Failure, User>> getUser(String username);
}