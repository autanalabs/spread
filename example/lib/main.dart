
import 'package:flutter/material.dart';
import 'package:spread/spread_builder.dart';
import 'package:spread/spread_emitter_mixin.dart';
import 'package:spread/spread_observer.dart';
import 'package:spread/use_case.dart';

import '../fullDemo/pages/home/widgets/posts.dart';
import '../fullDemo/pages/home/widgets/users.dart';
import '../fullDemo/services.dart';
import '../fullDemo/users/user_states.dart';

void main() {
  UsersObserver().selfRegister();
  runApp(const MyApp());
}

// The DemoApp has two states defined by the AppState enum.

enum AppState {
  users, posts
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Spread Demo App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: HomePage(),
  );
}
}

// A demo page with BottomNavigationBar.
// - the body is built depending of the state of type AppState

class HomePage extends StatelessWidget with StateEmitter {

  HomePage({super.key
  });

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
        )
    );
  }

  Widget _homeBody(BuildContext context, AppState? state) {
    switch(state) {
      case AppState.posts: {
        return PostsPage();
      }
      case AppState.users:
      default: {
        return UsersPage();
      }
    }
  }

  AppBar get _appbar => AppBar(
    title: const Text('Spread Full Demo'),
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
        showUsers();
        break;
      }
      case 1: {
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

// Create a UseCase to perform actions and notify states

class LoadUsersUseCase with StateEmitter implements UseCase {

  @override
  void execute() async {
    emit<UsersState>(LoadingUsers());
    Services().userService.getUsers()
        .then((users) {
      emit<UsersState>(LoadedUsersSuccess(users: users));
    })
        .onError((error, stackTrace) {
      emit<UsersState>(LoadedUsersFail(
          error: error,
          stackTrace: stackTrace
      ));
    });
  }
}

// Create a State observer service to listen and handle states asynchronously

class UsersObserver extends SpreadObserver<UsersState> {

  @override
  onState(UsersState state) {
    print("UsersObserver Observed: ${state.toString()}");
  }
}
