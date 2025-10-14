import 'package:flutter_test/flutter_test.dart';
import 'package:test_group_project/main.dart';

void main() {
  testWidgets('App loads and shows expected home screen text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();
  });
}
