
import 'package:flutter/material.dart';
import 'package:spread/spread_builder.dart';
import 'package:spread/spread_state.dart';
import 'states.dart';
import 'config.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: _appbar,
        bottomNavigationBar: _navigator(context),
        body: Spread<AppState>(
          builder: _homeBody,
        )
    );
  }

  Widget _homeBody(BuildContext context, AppState? state) {
    switch(state.runtimeType) {
      case PostsState: {
        return _postsPageBuilder(context);
      }
      case UsersState:
      default: {
        return _usersPageBuilder(context);
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

  Widget _usersPageBuilder(BuildContext context) => const Center(child:Text('users'));

  Widget _postsPageBuilder(BuildContext context) => const Center(child:Text('posts'));

  Future onNavigatorTap(int index) async {
    print('navigator tap: $index');
    switch(index) {
      case 0: {
        SpreadState().emit<AppState>(UsersState());
        break;
      }
      case 1: {
        SpreadState().emit<AppState>(PostsState());
        break;
      }
    }
  }
}