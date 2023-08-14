import 'package:flutter/material.dart';
import 'package:spread/spread.dart';
import '../states.dart';

class UsersPage extends StatelessWidget {
  final UserCounterState users;
  const UsersPage({super.key, required this.users});

  @override
  Widget build(BuildContext context) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spread<UserCounterState>(
              entity: users,
              builder: (BuildContext context, UserCounterState? state) {
                return Text(state?.count.toString() ?? "<USERS>");
              }),
          IconButton(
              onPressed: () {
                print('increment users');
                users.increment();
                SpreadState().emitEntity(users);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ));
}
