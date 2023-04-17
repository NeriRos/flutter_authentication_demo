import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_demo/src/models/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<MockUserCredential> signInWithCredential(
      AuthCredential credential) async {
    return MockUserCredential();
  }
}

class MockUserCredential extends Mock implements UserCredential {}

class TestAuthentication extends Authentication {
  TestAuthentication(mockFirebaseAuth) : super(mockFirebaseAuth);

  useLocalEmulator() {
    auth.useAuthEmulator('localhost', 9099);
  }
}

void main() {
  late TestAuthentication auth;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    auth = TestAuthentication(mockFirebaseAuth);
  });

  group("Authentication methods", () {
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

    testWidgets('Sign in with google should work', (WidgetTester tester) async {
      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => MockUserCredential());

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                await auth.authenticateWithGoogle(context);
              },
              child: const Text('Sign In'),
            );
          },
        ),
      ));

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      verify(() => mockFirebaseAuth.signInWithCredential(any())).called(1);
    }, skip: true);
  });
}
