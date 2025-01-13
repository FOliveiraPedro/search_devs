import 'package:dartz/dartz.dart';

import '../../../shared/errors.dart';
import '../entity/repo.dart';

abstract class GetReposRepository{
  Future<Either<Failure, List<Repo>>> getRepos(String username, int page);
}