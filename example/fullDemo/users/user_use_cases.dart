
import 'package:spread/use_case.dart';
import 'package:spread/spread_state.dart';
import '../services.dart';
import 'user_states.dart';

class LoadUsersUseCase implements UseCase {

  @override
  void execute() async {
    SpreadState().emit<UsersState>(LoadingUsers());
    Services().userService.getUsers()
    .then((users) {
      SpreadState().emit<UsersState>(LoadedUsersSuccess(users: users));
    })
    .onError((error, stackTrace) {
      SpreadState().emit<UsersState>(LoadedUsersFail(
          error: error,
          stackTrace: stackTrace
      ));
    });
  }
}

