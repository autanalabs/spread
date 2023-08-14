
import 'package:flutter/cupertino.dart';
import 'package:spread/src/spread_builder.dart';
import '../states.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  
  @override
  Widget build(BuildContext context) => Spread<AppState>(
      builder: (BuildContext context, AppState? state) {
        return Center(
          child: Text(state?.toString() ?? "<USERS>"),
        );
      }
  );

}