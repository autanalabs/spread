
import 'package:spread/spread.dart';
import '../services.dart';
import 'user.dart';
import 'user_states.dart';

class LoadUsersUseCase with StateEmitter implements UseCase {

  @override
  void execute() async {
    final List<User>? usersCached = SpreadState().getNamed<List<User>>(
        "users_cache");
    if (usersCached != null) {
      emit<UsersState>(LoadedUsersSuccess(users: usersCached));
    } else {
      emit<UsersState>(LoadingUsers());
      Services().userService.getUsers()
          .then((users) {
        emitNamed("users_cache", users);
        emit<UsersState>(LoadedUsersSuccess(users: users));
      })
          .onError((error, stackTrace) {
        emit<UsersState>(LoadedUsersFail(
            error: error,
            stackTrace: stackTrace
        ));
      });
    }
  }
}

