import 'package:bagaicha_florashop/feature/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginViewModel {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginBloc loginViewModel;

  setUp(() {
    loginViewModel = MockLoginBloc();
  });
}

class IntegrationTestWidgetsFlutterBinding {
  static void ensureInitialized() {}
}
