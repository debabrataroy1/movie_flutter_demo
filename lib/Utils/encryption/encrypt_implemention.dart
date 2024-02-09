import 'package:encrypt/encrypt.dart';
import 'package:movie_flutter_demo/Utils/app_encryption.dart';

class Encrypt implements Encryption{
  @override
   String decrypt(String keyString, String encryptedString) {
    final encryptedData = Encrypted.fromBase64(encryptedString);
    final key = Key.fromUtf8(keyString);
    final encrypt = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    return encrypt.decrypt(encryptedData, iv: initVector);
  }

  @override
   String encrypt(String keyString, String plainText) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
    return encryptedData.base64;
  }
}