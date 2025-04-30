import 'package:breathing_analysis_app/core/type_defs.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData();
}

class UserAPI implements IUserAPI {
  @override
  FutureEitherVoid saveUserData() {}
}
