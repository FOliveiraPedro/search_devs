import '../../../core/domain/entity/repo.dart';

abstract class ProfileState {}

class StartState implements ProfileState {
  const StartState();
}

class LoadingState implements ProfileState {
  const LoadingState();
}

class ErrorState implements ProfileState {
  final String message;
  const ErrorState(this.message);
}

class SuccessState implements ProfileState {
  final List<Repo> repoList;
  const SuccessState(this.repoList);
}

class NotLoggedState implements ProfileState {
  const NotLoggedState();
}
