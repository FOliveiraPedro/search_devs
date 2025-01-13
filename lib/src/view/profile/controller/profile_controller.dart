//Package
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:search_devs/src/core/domain/repository/get_repos_repository.dart';
import 'package:search_devs/src/core/domain/usecase/get_repos_usecase.dart';

//Project
import '../../../core/domain/entity/repo.dart';
import '../states/profile_states.dart';

@Injectable()
class ProfileController extends Bloc<String, ProfileState>
    implements Disposable {
  final GetReposUsecase getReposUsecase;

  ProfileController(this.getReposUsecase) : super(const StartState());
  List<Repo> repoList = [];

  @override
  Stream<ProfileState> mapEventToState(String event) async* {
    yield const LoadingState();
    ErrorState? errorState;

    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      var result = await getReposUsecase(event,1);
      result.fold(
        (failure) {
          print('failure');
          print(failure);
          errorState = ErrorState('failure');
        },
        (success) {
          repoList = success;
          print(success);
        },
      );
    } else {}
    if (errorState != null) {
      print('failure');
      yield errorState!;
    } else {
      yield SuccessState(repoList);
    }
  }

  Future<List<Repo>> getNewRepos(String username, int page) async{
    List<Repo> newRepoList = [];
    var result = await getReposUsecase(username,page);
    result.fold(
          (failure) {
        print('failure');
        print(failure);
      },
          (success) {
        newRepoList = success;
        print(success);

      },
    );
    return newRepoList;
  }

  @override
  void dispose() {
    close();
  }
}
