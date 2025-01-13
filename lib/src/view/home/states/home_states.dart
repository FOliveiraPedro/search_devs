import '../../../core/domain/entity/user.dart';

abstract class HomeState {}

class StartState implements HomeState {
  const StartState();
}

class LoadingState implements HomeState {
  const LoadingState();
}

class ErrorState implements HomeState {
  final String message;
  const ErrorState(this.message);
}

class SuccessState implements HomeState {
  final User user;
  const SuccessState(this.user);
}

class NotLoggedState implements HomeState {
  const NotLoggedState();
}
