import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_app_management/core/utils/storage/secure_storage_util.dart';

final userStorageProvider = Provider<UserStorageWrapper>((ref) {
  return UserStorageWrapper();
});