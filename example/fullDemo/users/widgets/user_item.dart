import 'package:flutter/material.dart';
import 'package:spread/src/spread_builder.dart';
import '../user.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(user.id.toString()),
        subtitle: Row(
          children: [
            Text(user.name.toString()),
            const SizedBox(width: 10),
            Spread<User>(
                entity: user,
                stateCondition: (User? entity) => entity!.posts.length.isEven,
                builder: (BuildContext context, User? entity) {
                  return Text('- posts: ${entity!.posts.length.toString()}');
                })
          ],
        ));
  }
}
