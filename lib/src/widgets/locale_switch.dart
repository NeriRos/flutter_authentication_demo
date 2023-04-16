import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocaleSwitch extends StatelessWidget {
  const LocaleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locals = context.supportedLocales;

    if (locals.isEmpty) {
      return Container();
    }

    onLanguageChange(locale) {
      context.setLocale(locale);
    }

    return DropdownMenu(
      initialSelection: context.locale,
      dropdownMenuEntries: locals
          .map((e) => DropdownMenuEntry(
                label: e.languageCode,
                value: e,
              ))
          .toList(),
      onSelected: onLanguageChange,
    );
  }
}
