
import 'package:flutter/widgets.dart';
import 'package:spread/entity.dart';
import 'package:spread/spread_state.dart';

class Spread<T> extends StatefulWidget {
  final String? stateName;
  final Entity? entity;
  final Widget Function(BuildContext, T?) builder;
  late final bool isTyped;
  late final bool isEntity;
  late final String typeName;

  Spread({super.key, this.stateName, this.entity, required this.builder}) {
    if (T == dynamic) {
      isTyped = false;
      typeName = "dynamic";
      if (stateName == null) {
        throw 'stateName must be specified for non typed Spread';
      }
    } else {
      isTyped = true;
      typeName = 'type:${T.toString()}';
      isEntity = entity != null;
    }
  }

  @override
  State<Spread<T>> createState() =>_SpreadState<T>();

}

class _SpreadState<T> extends State<Spread<T>> {
  T? currentState;
  Subscription? subscription;
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, currentState ?? _lastState);
  }

  T? get _lastState {
    late T? state;
    if (widget.isTyped) {
      if (widget.isEntity) {
        state = SpreadState().getEntity<T>(widget.entity!.entityId);

      } else {
        state = SpreadState().getNamed(widget.typeName);
      }

    } else {
      state = SpreadState().getNamed(widget.stateName!);
    }
    return state;
  }

  void _updateState(dynamic state) {
    setState(() {
      currentState = state;
    });
  }

  void _onSubscriptionCreated(Subscription subscription) {
    this.subscription = subscription;
  }

  @override
  void initState() {
    super.initState();
     if (widget.isTyped) {
       if (widget.isEntity) {
         this.currentState = widget.entity as T;
         SpreadState().subscribeEntity(widget.entity!, _updateState)
             .then(_onSubscriptionCreated);

       } else {
         SpreadState().subscribe<T>(_updateState)
             .then(_onSubscriptionCreated);
       }

     } else {
        SpreadState().subscribeNamed(widget.stateName!, _updateState)
        .then(_onSubscriptionCreated);
      }
  }

  @override
  void dispose() {
    subscription?.unSubscribe();
    super.dispose();
  }
}