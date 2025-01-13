//Package
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:search_devs/src/core/domain/usecase/get_user_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Project
import '../../../core/domain/entity/user.dart';
import '../states/home_states.dart';

@Injectable()
class HomeController extends Bloc<String, HomeState> implements Disposable {
  final GetUserUsecase getUserUsecase;

  HomeController(this.getUserUsecase) : super(const StartState());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late User user;

  @override
  Stream<HomeState> mapEventToState(String event) async* {
    final SharedPreferences prefs = await _prefs;
    yield const LoadingState();
    ErrorState? errorState;

    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      var result = await getUserUsecase(event);
      result.fold(
        (failure) {
          print('failure');
          print(failure);
          errorState = ErrorState('Usuario não encontrado');
        },
        (success) {
          List<String>? lastSearchs = prefs.getStringList("last_search");
          lastSearchs ??= [];
          if (lastSearchs.length == 5) {
            lastSearchs = lastSearchs.removeAt(0) as List<String>?;
          }
          if(!(lastSearchs!.contains(event))) {
            lastSearchs.add(event);
          }
          user = success;
          print("lastSearchs");
          print(lastSearchs);
          prefs.setStringList(
            "last_search",
            lastSearchs!,
          );

        },
      );
    } else {}
    if (errorState != null) {
      print('failure');
      yield errorState!;
    } else {
      yield SuccessState(user);
    }
  }

  Future<List<String>> getSuggestionList() async{
    final SharedPreferences prefs = await _prefs;
    List<String>? lastSearchs = prefs.getStringList("last_search");
    lastSearchs ??= [];
    print(lastSearchs);
    return lastSearchs;
  }

  @override
  void dispose() {
    close();
  }
}
