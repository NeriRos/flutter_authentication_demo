// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "app_title": "Authentication",
  "login": "Login",
  "register": "Register"
};
static const Map<String,dynamic> he = {
  "app_title": "התחברות",
  "login": "התחברות",
  "register": "הרשמה"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "he": he};
}
