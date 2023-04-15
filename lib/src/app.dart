import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/main.dart';
import 'package:flutter_authentication_demo/src/pages/authentication.dart';
import 'package:flutter_authentication_demo/src/pages/error.dart';
import 'package:flutter_authentication_demo/src/pages/loading.dart';
import 'package:flutter_authentication_demo/src/providers/authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/home.dart';

class AuthApp extends ConsumerWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseInitializerProvider);

    return initialize.when(
        data: (data) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: ref.watch(authStateProvider).when(
                data: (data) {
                  if (data != null) return const HomePage();
                  return const AuthenticationPage();
                },
                loading: () => const LoadingScreen(),
                error: (e, trace) => ErrorScreen(e, trace)),
          );
        },
        error: (e, stackTrace) => ErrorScreen(e, stackTrace),
        loading: () => const LoadingScreen());
  }
}
