
import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<List<int>> cipherKey() async {
  final secureStorage = const FlutterSecureStorage();

  var keyString = await secureStorage.read(key: 'hydrated_key');

  if (keyString == null) {
    final random = Random.secure();
    final key = List<int>.generate(32, (_) => random.nextInt(256));
    keyString = base64UrlEncode(key);
    await secureStorage.write(key: 'hydrated_key', value: keyString);
  }

  return base64Url.decode(keyString);
}



