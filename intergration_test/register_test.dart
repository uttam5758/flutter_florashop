import 'package:bagaicha_florashop/feature/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:bagaicha_florashop/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:bloc_test/bloc_test.dart';

import 'login_test.dart';

class MogckRegisteBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterViewModel {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MogckRegisteBloc registerBloc;
}
