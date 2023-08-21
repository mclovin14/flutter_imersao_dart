import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/functionalProgramming/nil.dart';
import 'package:barbershop/src/services/user_login/user_login_service.dart';

import '../../repositories/user/user_repository.dart';
import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRepository useRepository;
  final UserLoginService userLoginService;
  UserRegisterAdmServiceImpl({
    required this.useRepository,
    required this.userLoginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult =  await useRepository.registerAdmin(userData);
    switch(registerResult){
      case Success():
        return await userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
      }
}
