
import 'dart:async';
import 'user.dart';
import '../ports/posts_port.dart';

abstract class UserService {
  Future<List<User>> getUsers();
}

class UserServiceImpl implements UserService {
  final PostsPort repository;

  UserServiceImpl({required this.repository});

  @override
  Future <List<User>> getUsers() async {
   return repository.findAllUsers();
  }
}
