import 'package:argon_admin/utilities/custome_dialog.dart';
import 'package:kiwi/kiwi.dart';
part "app_module.g.dart";

abstract class AppModule {
  @Register.singleton(CustomDialogs)
  void configure();
}

void setup() {
  var appModule = _$AppModule();
  appModule.configure();
}
