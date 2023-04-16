import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/generated/locale_keys.g.dart';
import 'package:flutter_authentication_demo/src/providers/authentication.dart';
import 'package:flutter_authentication_demo/src/widgets/main_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authenticationProvider);
    var locale = context.locale;

    return Scaffold(
      appBar: MainAppBar(),
      body: provider.user != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: provider.signOut,
                    child: Text(LocaleKeys.signOut.tr()))
              ],
            )
          : Center(child: Text(LocaleKeys.noUser.tr())),
    );
  }
}
