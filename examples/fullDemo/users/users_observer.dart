
import 'package:spread/spread_observer.dart';
import 'user_states.dart';

class UsersObserver extends SpreadObserver<UsersState> {

  @override
  onState(UsersState state) {
    print("UsersObserver Observed: ${state.toString()}");
  }
}