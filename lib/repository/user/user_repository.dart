import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

@visibleForTesting
Map<String, User> userDb = {};

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  final String id;
  final String name;
  final String username;
  final String password;

  @override
  List<Object> get props => [id, name, username, password];
}

class UserRepository {
  Future<User?> userFromCredentials(String username, String password) async {
    final hashedPassword = password.hashValue;
    final users = userDb.values.where(
      (user) => user.username == username && user.password == hashedPassword,
    );

    if (users.isNotEmpty) {
      return users.first;
    }

    return null;
  }

  Future<User?> userFromId(String id) async {
    return userDb[id];
  }

  Future<String> createUser({
    required String name,
    required String username,
    required String password,
  }) {
    final id = username.hashValue;

    final user =
        User(id: id, name: name, username: username, password: password);

    userDb[id] = user;

    return Future.value(id);
  }

  void deleteUser(String id) {
    userDb.remove(id);
  }

  Future<void> updateUser({
    required String id,
    required String? name,
    required String? username,
    required String? password,
  }) async {
    final currentUser = userDb[id];

    if (currentUser == null) {
      return Future.error(Exception('User not found'));
    }

    if (password != null) {
      password = password.hashValue;
    }

    final user = User(
      id: id,
      name: name ?? currentUser.name,
      username: username ?? currentUser.username,
      password: password ?? currentUser.password,
    );

    userDb[id] = user;
  }
}
