
import 'package:spread/spread.dart';
import 'user_states.dart';

class UsersObserver extends SpreadObserver<UsersState> {

  @override
  onState(UsersState state) {
    print("UsersObserver Observed: ${state.toString()}");
  }
}