import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/src/pages/error.dart';
import 'package:flutter_authentication_demo/src/pages/loading.dart';
import 'package:flutter_authentication_demo/src/providers/authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    var actionText = _status == Status.login ? 'Login' : 'Sign Up';
    var provider = ref.watch(authenticationProvider);

    provider.authStateChange.listen((event) {
      print(event);
    });

    signIn() {
      provider.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text, context);
    }

    signUp() {
      provider.signUpWithEmailAndPassword(
          _emailController.text, _passwordController.text, context);
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  Text(actionText),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
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
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _passwordController.text) {
                          return 'Please enter your password again';
                        }
                        return null;
                      },
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
                        ? 'Create an account'
                        : 'Already have an account?'),
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
