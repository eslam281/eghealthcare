import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


abstract class EncryptionKeyService {
  Future<List<int>> getKey();
}
class EncryptionKeyServiceImpl implements EncryptionKeyService {
  final FlutterSecureStorage _secureStorage;

  EncryptionKeyServiceImpl(this._secureStorage);

  @override
  Future<List<int>> getKey() async {
    var keyString = await _secureStorage.read(key: 'hydrated_key');

    if (keyString == null) {
      final random = Random.secure();
      final key = List<int>.generate(32, (_) => random.nextInt(256));
      keyString = base64UrlEncode(key);
      await _secureStorage.write(key: 'hydrated_key', value: keyString);
    }

    return base64Url.decode(keyString);
  }
}
