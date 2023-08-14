
import 'package:flutter/material.dart';
import 'package:spread/spread.dart';
import 'config.dart';

class HomePage extends StatelessWidget {
  static const namedState = "homeTab";
  static const postsState = "posts";
  static const usersState = "users";

  const HomePage({super.key
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: _appbar,
        bottomNavigationBar: _navigator(context),
        body: Spread(
          stateName: namedState,
          builder: _homeBody,
        )
    );
  }

  Widget _homeBody(BuildContext context, dynamic state) {
    switch(state) {
      case postsState: {
        return _postsPageBuilder(context);
      }
      case usersState:
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
        SpreadState().emitNamed(namedState, usersState);
        break;
      }
      case 1: {
        SpreadState().emitNamed(namedState, postsState);
        break;
      }
    }
  }
}