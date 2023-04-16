import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/src/widgets/locale_switch.dart';
import 'package:flutter_authentication_demo/generated/locale_keys.g.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(LocaleKeys.appTitle.tr()),
      actions: const [LocaleSwitch()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
