## Spread Library

Easily manage and observe the state of your Flutter applications.

### Overview

The Spread library offers a simplified way of managing state within Flutter applications. With the use of entities, subscribers, and state emitters, developers can easily store, observe, and manipulate states without the usual boilerplate.

### Features

*   State Management: Store state data using identifiers, types, or entities. It's like a Key-Value map with observable events.
*   Spread Widget: Update UI when receive a state update.  
*   Observers: Subscribe to specific state changes and react accordingly.
*   State Emitters: a Mixin to Emit state changes based on types, names, or entities.
*   Use Cases: Abstracted business or domain logic encapsulation with the UseCase class.
*   Entities: Subscribe UI changes to a specific object instance identified by Type and ID.

### Getting Started

#### Installation

Include the library in your pubspec.yaml:

```yaml

dependencies:
   spread: ^0.0.8
```

#### Then run:

```bash

pub get
```

#### Basic Usage

Define a entity state and create a Spread widget subscribed to that entity with conditional build.

```dart
import 'package:spread/spread.dart';

class User implements Entity {
  final String id;
  final String name;
  final List<UserPost> posts = List.empty(growable: true);

  User({required this.id, required this.name});

  @override
  String get entityId => id;
}

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({super.key, required this.user});

    @override
    Widget build(BuildContext context) {
      return Spread<User>(
          entity: user,
          stateCondition: (User? entity) => entity!.posts.length.isEven,
          builder: (BuildContext context, User? entity) {
            return Text('- posts: ${entity!.posts.length.toString()}');
          });
    }
}
```

Define a typed entity and Create a Spread Widget subscribed to inherited type states.


```dart
import 'user.dart';

abstract class UsersState {}

class LoadingUsers extends UsersState {}

class LoadedUsersSuccess extends UsersState {
  final List<User> users;

  LoadedUsersSuccess({required this.users});
}

class LoadedUsersFail extends UsersState {
  final Object? error;
  final StackTrace? stackTrace;

  LoadedUsersFail({required this.error, required this.stackTrace});
}

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Spread<UsersState>(builder: (BuildContext context, UsersState? state) {
        if (state == null) {
          return _loading();
        } else {
          switch (state.runtimeType) {
            case LoadedUsersSuccess:
              {
                return _userList(context, state as LoadedUsersSuccess);
              }
            case LoadedUsersFail:
              {
                return _fail(context, state as LoadedUsersFail);
              }
            case LoadingUsers:
            default:
              {
                return _loading();
              }
          }
        }
      });
  Widget _loading() => const Center(child: CircularProgressIndicator());
}
```

Create a Spread widget subscribed to a enum state change:

```dart

enum AppState { users, posts }

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Spread<AppState>(
      builder: _homeBody,
    );
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
}
```

#### Emitting state:

Using the StateEmitter mixin:

```dart
import 'package:spread/spread.dart';

class UserManager with StateEmitter {

  void updateUser(User user) {
    emitEntity<User>(user);
  }
}
```

#### Observing state:

Extend from the SpreadObserver:

```dart
import 'package:spread/spread.dart';

class UsersObserver extends SpreadObserver<UsersState> {
  
  @override
  onState(UsersState state) {
    print("UsersObserver Observed: ${state.toString()}");
  }
}
```

### Documentation

Detailed documentation is available in the source code.

### Contributing

Contributions, issues, and feature requests are welcome! See our contribution guidelines for more information.

### License

This project is licensed under the BSD License. See the LICENSE file for details.