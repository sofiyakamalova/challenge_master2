import 'package:challenge_master/src/feautures/screens/home/home_page.dart';
import 'package:challenge_master/src/provider/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LibraryProvider(),
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );
  });
}
