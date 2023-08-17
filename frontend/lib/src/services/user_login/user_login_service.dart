import 'package:barbershop/src/core/exceptions/service_exception.dart';

import '../../core/functionalProgramming/either.dart';
import '../../core/functionalProgramming/nil.dart';


abstract interface class UserLoginService {
Future<Either<ServiceException,Nil>> execute(String email, String password);
}