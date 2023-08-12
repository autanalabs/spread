
import 'package:flutter/material.dart';
import 'package:spread/spread_builder.dart';
import 'package:spread/spread_state.dart';
import 'widgets/posts.dart';
import 'widgets/users.dart';
import 'states.dart';
import 'config.dart';

class HomePage extends StatelessWidget {
  final UserCounterState users = UserCounterState(id: 'users');
  final PostCounterState posts = PostCounterState(id: 'posts');

  HomePage({super.key
  });

  @override
  Widget build(BuildContext context) {
    SpreadState().emit<CounterState>(users);
    SpreadState().emitEntity(users);
    SpreadState().emitEntity(posts);

    return Scaffold(
        appBar: _appbar,
        bottomNavigationBar: _navigator(context),
        body: Spread<CounterState>(
          builder: _homeBody,
        )
    );
  }

  Widget _homeBody(BuildContext context, CounterState? state) {
    switch(state.runtimeType) {
      case PostCounterState: {
        return PostsPage(posts: posts);
      }
      case UserCounterState:
      default: {
        return UsersPage(users: users);
      }
    }
  }

  AppBar get _appbar => AppBar(
    title: Text(appName),
  );

  BottomNavigationBar _navigator(BuildContext context) => BottomNavigationBar(
    onTap: onNavigatorTap,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Users',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.data_array),
        label: 'Posts',
      ),
    ],
  );


  Future onNavigatorTap(int index) async {
    print('navigator tap: $index');
    switch(index) {
      case 0: {
        users.increment();
        SpreadState().emit<CounterState>(users);
        break;
      }
      case 1: {
        posts.increment();
        SpreadState().emit<CounterState>(posts);
        break;
      }
    }
  }
}