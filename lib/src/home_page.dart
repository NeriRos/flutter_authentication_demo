import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  String uid = "";

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = FirebaseAuth.instance.currentUser!;
          uid = _user!.uid;
        });
      } else {
        if (mounted) {
          setState(() {
            _user = null;
            uid = "";
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signOut() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _user != null
            ? Text('Welcome ${_user?.displayName}')
            : const Text('Welcome'),
      ),
      body: _user != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: signOut, child: const Text('Sign out'))
              ],
            )
          : const Center(
              child: Text('No user detected'),
            ),
    );
  }
}
