// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tragent_frontend/shared/services/auth_provider.dart';
import 'package:tragent_frontend/core/theme/app_theme.dart';

void main() {
  testWidgets('MaterialApp builds successfully', (WidgetTester tester) async {
    // Create a simple test app
    final testApp = MaterialApp(
      title: 'Travel Agent AI',
      theme: AppTheme.lightTheme,
      home: const Scaffold(body: Center(child: Text('Test App'))),
    );

    // Build our test app
    await tester.pumpWidget(testApp);

    // Verify that we can find the MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Test App'), findsOneWidget);
  });

  testWidgets('AuthProvider works correctly', (WidgetTester tester) async {
    late AuthProvider authProvider;

    final testApp = MaterialApp(
      home: ChangeNotifierProvider<AuthProvider>(
        create: (context) {
          authProvider = AuthProvider();
          return authProvider;
        },
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            return Scaffold(
              body: Column(
                children: [
                  Text(auth.isGuestMode ? 'Guest' : 'Authenticated'),
                  Text('User: ${auth.user?.name ?? "No user"}'),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.pumpWidget(testApp);

    // Enable guest mode to test functionality
    authProvider.continueAsGuest();
    await tester.pump(); // Rebuild after state change

    // Should now be in guest mode
    expect(find.text('Guest'), findsOneWidget);
    expect(find.text('User: Guest User'), findsOneWidget);
    expect(authProvider.isGuestMode, isTrue);
  });

  testWidgets('App theme configuration is correct', (
    WidgetTester tester,
  ) async {
    final testApp = MaterialApp(
      title: 'Travel Agent AI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Scaffold(body: Text('Test')),
    );

    await tester.pumpWidget(testApp);

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'Travel Agent AI');
    expect(materialApp.theme, AppTheme.lightTheme);
    expect(materialApp.darkTheme, AppTheme.darkTheme);
  });

  testWidgets('Basic widget functionality', (WidgetTester tester) async {
    // Test a simple counter app to verify test environment
    int counter = 0;

    final testApp = MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            body: Column(
              children: [
                Text('Counter: $counter'),
                ElevatedButton(
                  onPressed: () => setState(() => counter++),
                  child: const Text('Increment'),
                ),
              ],
            ),
          );
        },
      ),
    );

    await tester.pumpWidget(testApp);

    // Initial state
    expect(find.text('Counter: 0'), findsOneWidget);

    // Tap button and check update
    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(find.text('Counter: 1'), findsOneWidget);
  });
}
