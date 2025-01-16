import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

@visibleForOverriding
Map<String, Session> sessionDb = {};

class Session extends Equatable {
  const Session({
    required this.token,
    required this.userId,
    required this.expiryDate,
    required this.createdAt,
  });

  final String token;
  final String userId;
  final DateTime expiryDate;
  final DateTime createdAt;

  @override
  List<Object> get props => [token, userId, expiryDate, createdAt];
}

class SessionRepository {
  /// Create session
  Session createSession(String userId) {
    final session = Session(
        token: generateToken(userId),
        userId: userId,
        expiryDate: DateTime.now().add(const Duration(hours: 24)),
        createdAt: DateTime.now());

    sessionDb[session.token] = session;
    return session;
  }

  /// generate token
  String generateToken(String userId) {
    return '${userId}_${DateTime.now().toIso8601String()}'.hashValue;
  }

  /// Search a session of a particular token
  Session? sessionFromToken(String token) {
    final session = sessionDb[token];

    if (session != null && session.expiryDate.isAfter(DateTime.now())) {
      return session;
    }
    return null;
  }
}
