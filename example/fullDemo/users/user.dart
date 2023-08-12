
import 'package:spread/entity.dart';
import 'package:spread/spread_emitter_mixin.dart';

class User with StateEmitter implements Entity {
  final int id;
  final String name;
  final List<UserPost> posts = List.empty(growable: true);

  User({required this.id, required this.name});

  dynamic toDynamic() => {
    'id': id,
    'name': name
  };

  static User fromDynamic(dynamic user) => User(
      id: user['id'],
      name: user['name']
  );


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User
        && other.id == id
        && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }

  @override
  String get entityId => id.toString();

  User generatePosts()  {
    _generateRandomPosts();
    return this;
  }

  void _generateRandomPosts() async {
    for(int i=0; i< 100; i++) {
      final post = await _generateRandomPost();
      print('added post');
      posts.add(post);
      emitEntity<User>(this);
    }
  }

  Future<UserPost> _generateRandomPost() async {
    return Future.delayed(
        const Duration(
          seconds: 1,
        ),
            () => UserPost(content: 'random content')
    );
  }
}

class UserPost {
  final String content;

  UserPost({required this.content});
}