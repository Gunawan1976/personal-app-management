// ignore_for_file: constant_identifier_names

import 'package:flutter/services.dart';

class Constant {
  static const APP_TITLE='Virtual Command Center';
  static const String APP_STATE_KEY = 'APP_STATE';
  static const String APP_TOKEN = 'token';
  static const String REFRESH_TOKEN = 'refresh_token';
  static const String RESPONSE_CSRF_TOKEN = 'csrf_token';
  static const String CSRF_TOKEN_LOGIN = 'csrf_token_login';
  static const String DATA_USER = 'data_user';
  static const String levelUser = 'level_user';
  static const String unitCode = 'unit_code';
  static const String deviceId = 'deviceId';
  static const String lastLogin = 'last_login';
  static const MethodChannel methodChannel = MethodChannel('custom_keyboard_channel');
  static const MethodChannel signatureMethodChannel = MethodChannel('signature_channel');

  // //BASE URL
  // static const String BASE_URL = 'https://stg-new-vcc-be.pln.co.id/vcc/';
  // static const String BASE_URL_PLNMOBILE = 'https://stg-new-vcc-plnmobile.pln.co.id/plnmobile/';
  // static const String CERT_SHA256_FINGERPRINT = "1C:F4:BE:7F:99:44:81:87:CD:EE:0E:E6:09:08:97:91:FD:AC:BB:AB:F6:61:6F:40:B5:DC:32:63:52:CD:B7:4D";
  // static const String HOST_URL = 'stg-new-vcc-be.pln.co.id';
  // static const String HOST_URL_PLNMOBILE = 'stg-new-vcc-plnmobile.pln.co.id';

  //BASE URL PROD
  static const String BASE_URL = 'https://dummyjson.com/';
  // static const String BASE_URL_PLNMOBILE = 'https://new-vcc-plnmobile.pln.co.id/plnmobile/';
  // static const String CERT_SHA256_FINGERPRINT = "1C:F4:BE:7F:99:44:81:87:CD:EE:0E:E6:09:08:97:91:FD:AC:BB:AB:F6:61:6F:40:B5:DC:32:63:52:CD:B7:4D";
  // static const String HOST_URL = 'new-vcc-be.pln.co.id';
  // static const String HOST_URL_PLNMOBILE = 'new-vcc-plnmobile.pln.co.id';

  // static const String BASE_URL = 'http://172.16.1.99:5000/vcc/';
  // static const String BASE_URL_PLNMOBILE = 'http://172.16.1.99:5001/plnmobile/';
  // static const String CERT_SHA256_FINGERPRINT = "";
  // static const String HOST_URL = '127.0.0.1:5000';

  // static const String BASE_URL = 'http://10.0.2.2:8082/vcc/';
  // static const String BASE_URL_PLNMOBILE = 'http://10.0.2.2:8083/plnmobile/';
  // static const String CERT_SHA256_FINGERPRINT = "";
  // static const String HOST_URL = '127.0.0.1:5000';

  // static const String BASE_URL = 'http://172.16.1.51:8082/vcc/';
  // static const String BASE_URL_PLNMOBILE = 'http://172.16.1.51:8083/plnmobile/';
  // static const String CERT_SHA256_FINGERPRINT = "";
  // static const String HOST_URL = '127.0.0.1:5000';
  // static const String HOST_URL_PLNMOBILE = '127.0.0.1:5000';

  static const String APP_STATE_ONBOARDING_KEY = "APP_STATE_ONBOARDING";
  static const String APP_STATE_USER_CREDENTIAL_KEY = 'APP_STATE_USER_CREDENTIAL';
  static const String APP_STATE_USER_DEVICE_TOKEN_KEY = 'APP_STATE_USER_DEVICE_TOKEN';

  static const appMaincolor = "#00A2B9";
}