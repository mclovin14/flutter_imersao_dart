
import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm{
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {

    final loaderHandle = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

     switch(result){
      case Success():
        //! invalidando cache para evitar o login com usuário errado
        ref.invalidate(getSessionProvider);
        ref.invalidate(getBarbershopProvider);
        final userModel = await ref.read(getSessionProvider.future);
        switch(userModel){
          case UserModelADM():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
      break;                  // exatamente abaixo aqui, eu faço uam destrução do obj ServiceException pegando somente a mensagem dele
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message
          );
        break;
     }
     loaderHandle.close();
  }
}