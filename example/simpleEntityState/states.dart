
import 'package:spread/entity.dart';

abstract class CounterState
    implements Entity {
  final String id;
  int _count = 0;

  CounterState(this.id);

  void increment() {
    _count ++;
  }
  int get count => _count;

  @override
  String get entityId => id;
}

class UserCounterState extends CounterState {
  UserCounterState({required String id}) : super(id);
}

class PostCounterState extends CounterState {
  PostCounterState({required String id}) : super(id);
}