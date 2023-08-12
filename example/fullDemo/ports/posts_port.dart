import 'dart:async';
import 'dart:math';

import '../users/user.dart';

abstract class PostsPort {
  Future<List<User>> findAllUsers();
}

class PostsApiPort implements PostsPort {
  Random random = Random();

  @override
  Future<List<User>> findAllUsers() async {
    final id = random.nextInt(1000);
    return Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () => [
          User(id: id, name: "aaaa").generatePosts(),
          User(id: id + 500, name: "bbbb").generatePosts()
        ]
    );
  }
}
