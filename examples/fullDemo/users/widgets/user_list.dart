
import 'package:flutter/material.dart';
import 'user_item.dart';
import '../user_states.dart';

class UsersList extends StatelessWidget {
  final UsersState? state;

  const UsersList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state == null) {
      return _loading();

    } else {
      switch (state.runtimeType) {
        case LoadedUsersSuccess: {
          return _userList(context, state as LoadedUsersSuccess);
        }
        case LoadedUsersFail: {
          return _fail(context, state as LoadedUsersFail);
        }
        case LoadingUsers:
        default: {
          return _loading();
        }
      }
    }
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _userList(BuildContext context, LoadedUsersSuccess state) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (BuildContext context, int index) {
        return UserItem(
          user: state.users[index]
        );
      },
    );
  }

  Widget _fail(BuildContext context, LoadedUsersFail fail) {
    return Center(child: Text('Error: ${fail.error}'));
  }

}