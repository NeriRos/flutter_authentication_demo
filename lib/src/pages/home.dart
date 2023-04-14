import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/src/providers/authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authenticationProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: provider.user != null
            ? Text('Welcome ${provider.user?.email}')
            : const Text('Welcome'),
      ),
      body: provider.user != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: provider.signOut, child: const Text('Sign out'))
              ],
            )
          : const Center(
              child: Text('No user detected'),
            ),
    );
  }
}
