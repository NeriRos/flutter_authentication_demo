import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseAuth.instance.signOut();

  runApp(const AuthApp());
}
