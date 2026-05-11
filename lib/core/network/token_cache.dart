import '../constant.dart';
import '../utils/storage/secure_storage_util.dart';

class TokenCache {
  static String? csrfToken;
  static String? csrfTokenLogin;
  static String? responseToken;

  // Inisialisasi token dari secure storage saat aplikasi mulai
  static Future<void> init() async {
    // csrfToken = await UserSecureStorage.getField(Constant.CSRF_TOKEN);
    csrfTokenLogin = await UserSecureStorage.getField(Constant.CSRF_TOKEN_LOGIN);
    responseToken = await UserSecureStorage.getField(Constant.RESPONSE_CSRF_TOKEN);
  }

  // Update token setelah berhasil mendapatkan token baru
  static void updateTokens({String? newCsrfToken,String? newResponseToken,String? tokenLogin}) {


    csrfToken = newCsrfToken;
    responseToken = newResponseToken;
    csrfTokenLogin = tokenLogin;
  }
}
