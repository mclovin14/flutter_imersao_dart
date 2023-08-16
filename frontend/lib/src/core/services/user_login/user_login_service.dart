import 'package:barbershop/src/core/exceptions/service_exception.dart';

import '../../functionalProgramming/either.dart';
import '../../functionalProgramming/nil.dart';

abstract interface class UserLoginService {
Future<Either<ServiceException,Nil>> execute(String email, String password);
}