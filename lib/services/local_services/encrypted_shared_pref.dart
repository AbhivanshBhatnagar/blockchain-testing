import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final encryptedSharedPrefProvider = Provider((ref) => EncryptedSharedPref());

class EncryptedSharedPref {
  EncryptedSharedPreferences instance = EncryptedSharedPreferences();
}
