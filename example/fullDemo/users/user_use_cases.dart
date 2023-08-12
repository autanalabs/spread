
import 'package:spread/spread_emitter_mixin.dart';
import 'package:spread/use_case.dart';
import '../services.dart';
import 'user_states.dart';

class LoadUsersUseCase with StateEmitter implements UseCase {

  @override
  void execute() async {
    emit<UsersState>(LoadingUsers());
    Services().userService.getUsers()
    .then((users) {
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

