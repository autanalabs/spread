
import 'package:flutter/cupertino.dart';
import 'package:spread/spread_builder.dart';
import '../states.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) => Spread<AppState>(
      builder: (BuildContext context, AppState? state) {
        return Center(
          child: Text(state?.toString() ?? "<POSTS>"),
        );
      }
  );

}