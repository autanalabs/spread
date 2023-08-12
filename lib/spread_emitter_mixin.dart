
import 'package:spread/spread_state.dart';
import 'entity.dart';

mixin StateEmitter {

  void emit<T>(T state) async {
    SpreadState().emit<T>(state);
  }

  void emitNamed(String stateName, dynamic state) async {
    SpreadState().emitNamed(stateName, state);
  }

  void emitEntity<T extends Entity>(T entity) async {
    SpreadState().emitEntity<T>(entity);
  }
}