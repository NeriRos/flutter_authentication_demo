import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/firebase_options.dart';
import 'package:flutter_authentication_demo/src/models/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

class TestAuthentication extends Authentication {
  final FirebaseAuth _mockFirebaseAuth;
  final GoogleSignIn _mockGoogleSignIn;

  TestAuthentication(this._mockFirebaseAuth, this._mockGoogleSignIn);

  @override
  FirebaseAuth get _auth => _mockFirebaseAuth;

  useLocalEmulator() {
    _auth.useAuthEmulator('localhost', 9099);
  }

  @override
  GoogleSignIn get _googleSignIn => _mockGoogleSignIn;
}

void main() {
  late TestAuthentication auth;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // auth.useLocalEmulator();
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    auth = TestAuthentication(mockFirebaseAuth, mockGoogleSignIn);
  });

  testWidgets('Sign in with username and password should work',
      (WidgetTester tester) async {
    const email = 'test@example.com';
    const password = 'password';

    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => MockUserCredential());

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return TextButton(
            onPressed: () async {
              await auth.signInWithEmailAndPassword(email, password, context);
            },
            child: const Text('Sign In'),
          );
        },
      ),
    ));

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)).called(1);
  });
}
