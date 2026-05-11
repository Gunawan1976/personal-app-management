import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/router.dart';
import 'core/utils/util_helper.dart';
import 'core/network/token_cache.dart';
import 'core/utils/storage/secure_storage_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // const String key = String.fromEnvironment('KEY', defaultValue: 'dev-key');
  // const String iv = String.fromEnvironment('IV', defaultValue: 'dev-iv');
  //
  // await UserSecureStorage.setField("sec_key", key);
  // await UserSecureStorage.setField("iv", iv);
  // await TokenCache.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: router,
        scaffoldMessengerKey: UtilsHelper.scaffoldMessengerKey,
        title: 'Personal App Management',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}