
import 'package:flutter/material.dart';
import 'package:spread/spread_builder.dart';
import 'package:spread/spread_state.dart';
import 'widgets/posts.dart';
import 'widgets/users.dart';
import 'states.dart';
import 'config.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key
  });

  @override
  Widget build(BuildContext context) {
    SpreadState().emit<AppState>(AppState.users);
    return Scaffold(
        appBar: _appbar,
        bottomNavigationBar: _navigator(context),
        body: Spread<AppState>(
          builder: _homeBody,
        )
    );
  }

  Widget _homeBody(BuildContext context, AppState? state) {
    switch(state) {
      case AppState.posts: {
        return const UsersPage();
      }
      case AppState.users:
      default: {
        return const PostsPage();
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
        SpreadState().emit<AppState>(AppState.users);
        break;
      }
      case 1: {
        SpreadState().emit<AppState>(AppState.posts);
        break;
      }
    }
  }
}