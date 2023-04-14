import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'home_page.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providers = [EmailAuthProvider()];

    var onAuthChange = AuthStateChangeAction(
      ((context, state) {
        if (state is UserCreated || state is SignedIn) {
          var user = (state is SignedIn)
              ? state.user
              : (state as UserCreated).credential.user;
          if (user == null) {
            return;
          }
          if (!user.emailVerified && (state is UserCreated)) {
            user.sendEmailVerification();
          }
          if (state is UserCreated) {
            if (user.displayName == null && user.email != null) {
              var defaultDisplayName = user.email!.split('@')[0];
              user.updateDisplayName(defaultDisplayName);
            }
          }

          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', ((route) => false));
        }
      }),
    );

    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) {
          return SignInScreen(providers: providers, actions: [onAuthChange]);
        },
        '/': (context) => const HomePage(),
      },
    );
  }
}
