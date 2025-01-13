//Packages
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

//Project
import '../../../shared/errors.dart';
import '../entity/repo.dart';
import '../repository/get_repos_repository.dart';

abstract class GetReposUsecase {
  Future<Either<Failure, List<Repo>>> call(String token, int page);
}

@Injectable(singleton: false)
class GetReposUsecaseImpl implements GetReposUsecase {
  final GetReposRepository getReposRepository;

  GetReposUsecaseImpl(this.getReposRepository);

  @override
  Future<Either<Failure, List<Repo>>> call(String username, int page) async {
    var result = await getReposRepository.getRepos(username,page);
    return result;
  }
}