import 'package:equatable/equatable.dart';

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
