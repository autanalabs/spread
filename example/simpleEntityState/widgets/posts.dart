
import 'package:flutter/material.dart';
import 'package:spread/spread.dart';
import '../states.dart';

class PostsPage extends StatelessWidget {
  final PostCounterState posts;
  const PostsPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spread<PostCounterState>(
              entity: posts,
              builder: (BuildContext context, PostCounterState? state) {
                return Text(state?.count.toString() ?? "<POSTS>");
              }),
          IconButton(
              onPressed: () {
                print('increment posts');
                posts.increment();
                SpreadState().emitEntity(posts);
              },
              icon: const Icon(Icons.add_circle))
        ],
      )
  );
}