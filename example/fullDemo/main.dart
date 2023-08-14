import 'package:flutter/material.dart';
import 'ports/posts_port.dart';
import 'users/users_service.dart';
import 'users/users_observer.dart';
import 'services.dart';
import 'app.dart';

void main() {
  initServices();
  initObservers();
  runApp(const MyApp());
}

void initServices() async {
  Services()
      .init(userService: () => UserServiceImpl(repository: PostsApiPort()));
}

void initObservers() async {
  UsersObserver().selfRegister();
}
