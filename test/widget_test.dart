import 'package:flutter_authentication_demo/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login should work', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AuthApp());


  });
}
