
import 'user.dart';

abstract class UsersState {}

class LoadingUsers extends UsersState {}

class LoadedUsersSuccess extends UsersState {
  final List<User> users;

  LoadedUsersSuccess({required this.users});
}

class LoadedUsersFail extends UsersState {
  final Object? error;
  final StackTrace? stackTrace;

  LoadedUsersFail({required this.error, required this.stackTrace});
}