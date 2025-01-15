import 'dart:convert';

import 'package:crypto/crypto.dart';

extension HashStringExtension on String {
  // returns the hash value
  String get hashValue {
    return sha256.convert(utf8.encode(this)).toString();
  }
}
