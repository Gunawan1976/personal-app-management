import 'dart:convert';
// import 'package:cryptography/cryptography.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:personal_app_management/core/utils/storage/secure_storage_util.dart';
import 'package:personal_app_management/core/utils/util_helper.dart';
// import 'package:pointycastle/api.dart';
// import 'package:pointycastle/block/aes.dart';
// import 'package:pointycastle/block/modes/gcm.dart';

final nonce = List<int>.filled(12, 0);


class Aes256GcmWrapper {
  Future<String> encrypt(String cleartext) async {
    return Aes256Gcm.encrypt(cleartext);
  }

  Future<String> decrypt(String cipher, {String? key, String? iv}) {
    return Aes256Gcm.decrypt(cipher, key: key, iv: iv);
  }
}

class Aes256Gcm {
  /// Encrypts passed [cleartext] with key generated based on [secret] argument
  static Future<String> encrypt(String cleartext) async {
    try {
      final key = await UserSecureStorage.getField('sec_key');
      final decryptedKey = UtilsHelper.binaryToString(key ?? "");
      final iv = await UserSecureStorage.getField('iv');
      final decryptedIv = UtilsHelper.binaryToString(iv ?? "");

      if (decryptedKey.isEmpty || decryptedIv.isEmpty) {
        throw Exception('Key or IV is empty');
      }

      final secretBox = await cryptography.AesGcm.with256bits().encrypt(
        utf8.encode(cleartext),
        secretKey: cryptography.SecretKey(utf8.encode(decryptedKey)),
        nonce: nonce,
        aad: utf8.encode(decryptedIv),
      );

      final List<int> result = secretBox.cipherText + secretBox.mac.bytes;
      return base64.encode(result);
    } catch (e) {
      return Future.error('Encryption error');
    }
  }

  static Future<String> decrypt(String cipherText, {String? key, String? iv}) async {
    try {
      final decode = base64.decode(cipherText);
      final decryptedKey = UtilsHelper.binaryToString(key ?? "");
      final decryptedIv = UtilsHelper.binaryToString(iv ?? "");

      if (decryptedKey.isEmpty || decryptedIv.isEmpty) {
        throw Exception('Key or IV is empty');
      }

      var mac = decode.sublist(decode.length - 16);
      var encryptedText = decode.sublist(0, decode.length - 16);
      final secretBox = cryptography.SecretBox(encryptedText, nonce: nonce, mac: cryptography.Mac(mac));

      final cleartext = await cryptography.AesGcm.with256bits().decrypt(
        secretBox,
        secretKey: cryptography.SecretKey(utf8.encode(decryptedKey)),
        aad: utf8.encode(decryptedIv),
      );

      return utf8.decode(cleartext);
    } catch (e) {


      return Future.error('Decryption error');
    }
  }


}



