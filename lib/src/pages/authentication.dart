import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/generated/locale_keys.g.dart';
import 'package:flutter_authentication_demo/src/providers/authentication.dart';
import 'package:flutter_authentication_demo/src/widgets/main_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

enum Status {
  login,
  signUp,
}

class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  AuthenticationPageState createState() => AuthenticationPageState();
}

class AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Status _status = Status.login;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var actionText = _status == Status.login
        ? LocaleKeys.login.tr()
        : LocaleKeys.register.tr();
    var provider = ref.watch(authenticationProvider);
    var locale = context.locale;

    signIn() {
      provider.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text, context);
    }

    signUp() {
      provider.signUpWithEmailAndPassword(
          _emailController.text, _passwordController.text, context);
    }

    return Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  Text(actionText).tr(),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.email.tr(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains("@") ||
                          !value.contains(".")) {
                        return LocaleKeys.emailValidationMessage.tr();
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.password.tr(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.passwordValidationMessage
                            .tr(args: [""]);
                      }
                      return null;
                    },
                  ),
                  if (_status == Status.signUp)
                    TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.confirmPassword.tr(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _passwordController.text) {
                          return LocaleKeys.passwordValidationMessage
                              .tr(args: ["again"]);
                        }
                        return null;
                      },
                    ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await provider.authenticateWithGoogle(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage("assets/google_logo.png"),
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(LocaleKeys.signInWithGoogle.tr()),
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_status == Status.login) {
                          signIn();
                        } else {
                          signUp();
                        }
                      }
                    },
                    child: Text(actionText),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _status = _status == Status.login
                            ? Status.signUp
                            : Status.login;
                      });
                    },
                    child: Text(_status == Status.login
                        ? LocaleKeys.createAccount.tr()
                        : LocaleKeys.alreadyHaveAccount.tr()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
