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
   spread: ^0.0.4
```

#### Then run:

```bash

pub get
```

#### Basic Usage

Define a state entity:  


```dart
import 'package:spread/entity.dart';

class User implements Entity {
  final String id;
  final String name;

  User({required this.id, required this.name});

  @override
  String get entityId => id;
}
```

and/or Define a typed entity:


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
```

Create a Spread widget subscribed to a state change:

```dart
@override
Widget build(BuildContext context) {
    return Spread<AppState>(
      builder: _homeBody,
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

class UserObserver extends SpreadObserver {

  @override
  void onState(User user) {
    print('User updated: ${user.name}');
  }
}
```

### Documentation

Detailed documentation is available in the source code.

### Contributing

Contributions, issues, and feature requests are welcome! See our contribution guidelines for more information.

### License

This project is licensed under the BSD License. See the LICENSE file for details.