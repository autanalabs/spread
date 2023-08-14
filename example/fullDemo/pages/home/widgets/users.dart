import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spread/src/spread_builder.dart';
import '../../../users/widgets/user_list.dart';
import '../../../users/user_states.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Spread<UsersState>(builder: (BuildContext context, UsersState? state) {
        return UsersList(state: state);
      });
}
