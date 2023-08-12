
import 'users/users_service.dart';

class Services {
  static final Services _singleton = Services._internal();
  factory Services() {
    return _singleton;
  }
  Services._internal();
  late final UserService userService;

  void init({
    required UserService Function() userService,
  }) async {
    this.userService = userService.call();
  }
}