import 'package:barbershop/src/core/constants/local_storage_keys.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashState { initial, login, loggedADM, loggedEmployee, error }

@riverpod
class SplashVm extends _$SplashVm {
 
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(LocalStorageKeys.accessToken)) {
      ref.invalidate(getSessionProvider);
      ref.invalidate(getBarbershopProvider);

      final userModel = await ref.watch(getSessionProvider.future);

      try {
        return switch (userModel) {
          UserModelADM() => SplashState.loggedADM,
          UserModelEmployee() => SplashState.loggedEmployee
        };
      } catch (e) {
        return SplashState.login;
      }
    }

    return SplashState.login;
  }
}
