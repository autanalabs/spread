import 'package:flutter/material.dart';
import 'package:spread/spread.dart';
import '../../config.dart';
import '../../users/user_use_cases.dart';
import 'widgets/posts.dart';
import 'widgets/users.dart';
import 'states.dart';

class HomePage extends StatelessWidget with StateEmitter {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // set initial states
    emit<AppState>(AppState.users);
    LoadUsersUseCase().execute();

    return Scaffold(
        appBar: _appbar,
        bottomNavigationBar: _navigator(context),
        body: Spread<AppState>(
          builder: _homeBody,
        ));
  }

  Widget _homeBody(BuildContext context, AppState? state) {
    switch (state) {
      case AppState.posts:
        {
          return PostsPage();
        }
      case AppState.users:
      default:
        {
          return UsersPage();
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
    switch (index) {
      case 0:
        {
          showUsers();
          break;
        }
      case 1:
        {
          showPosts();
          break;
        }
    }
  }

  void showUsers() async {
    LoadUsersUseCase().execute();
    emit<AppState>(AppState.users);
  }

  void showPosts() async {
    emit<AppState>(AppState.posts);
  }
}
