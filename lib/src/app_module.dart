//Package
import 'package:flutter_modular/flutter_modular.dart';

//Project
import 'core/data/datasource/get_repos_datasource.dart';
import 'core/data/datasource/get_user_datasource.dart';
import 'core/data/repository/get_repos_repository_impl.dart';
import 'core/data/repository/get_user_repository_impl.dart';
import 'core/domain/repository/get_repos_repository.dart';
import 'core/domain/repository/get_user_repository.dart';
import 'core/domain/usecase/get_repos_usecase.dart';
import 'core/domain/usecase/get_user_usecase.dart';
import 'view/home/controller/home_controller.dart';
import 'view/home/home.dart';
import 'view/profile/controller/profile_controller.dart';
import 'view/profile/profile.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //Home Injection
    BindInject(
          (i) => GetUserDatasourceImpl(),
      isSingleton: false,
      isLazy: true,
    ),
    BindInject(
          (i) => GetUserRepositoryImpl(i<GetUserDatasource>()),
      isSingleton: false,
      isLazy: true,
    ),
    BindInject(
          (i) => GetUserUsecaseImpl(i<GetUserRepository>()),
      isSingleton: false,
      isLazy: true,
    ),
    BindInject(
          (i) => HomeController(i<GetUserUsecase>()),
      isSingleton: true,
      isLazy: true,
    ),

    //Home Injection
    BindInject(
          (i) => GetReposDatasourceImpl(),
      isSingleton: false,
      isLazy: true,
    ),
    BindInject(
          (i) => GetReposRepositoryImpl(i<GetReposDatasource>()),
      isSingleton: false,
      isLazy: true,
    ),
    BindInject(
          (i) => GetReposUsecaseImpl(i<GetReposRepository>()),
      isSingleton: false,
      isLazy: true,
    ),
    BindInject(
          (i) => ProfileController(i<GetReposUsecase>()),
      isSingleton: true,
      isLazy: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const Home()),
    ChildRoute('/home', child: (_, __) => const Home()),
    ChildRoute('/profile', child: (_, args) => Profile.fromArgs(args)),
  ];
}
