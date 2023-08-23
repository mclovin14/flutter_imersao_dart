import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/register/user/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus { initial, success, error }

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);

    final userData = (name: name, email: email, password: password);

    final registerResult =await userRegisterAdmService.execute(userData).asyncLoader();
    
    switch (registerResult) {
      case Success():
        ref.invalidate(getSessionProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}
