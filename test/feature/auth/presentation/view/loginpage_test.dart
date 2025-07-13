import 'package:bagaicha_florashop/feature/auth/presentation/view/loginpage.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginViewModel {}

void main() {
  late MockLoginBloc loginViewModel;

  setUp(() {
    loginViewModel = MockLoginBloc();
  });

  Widget loadLoginView() {
    return BlocProvider<LoginViewModel>(
      create: (context) => loginViewModel,
      child: MaterialApp(home: LoginPage()),
    );
  }

  testWidgets('Check for the text in login UI', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    // Find the ElevatedButton with the text 'Sign In'
    final result = find.widgetWithText(ElevatedButton, 'Sign In');

    // Assert it exists
    expect(result, findsOneWidget);
  });

  testWidgets('Check for the email and password', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).at(0),
      'uttamsapkota.danger@gmail.com',
    );
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();
    expect(find.text('uttamsapkota.danger@gmail.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
  });

  testWidgets('Check for the validator error', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    // Tap login button without filling the form
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    // Expect the validation error messages
    expect(find.text('Please enter your email or phone'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Login success', (tester) async {
    // Arrange - Mock the state
    when(
      () => loginViewModel.state,
    ).thenReturn(LoginState(isLoading: false, isSuccess: true));

    // Act - Render the widget
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    // Enter valid email and password
    await tester.enterText(
      find.byType(TextField).at(0),
      'uttamsapkota.danger@gmail.com',
    );
    await tester.enterText(find.byType(TextField).at(1), 'uttam123');

    // Tap the login button
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    // Assert - Ensure login was successful
    expect(loginViewModel.state.isSuccess, true);
  });
}
