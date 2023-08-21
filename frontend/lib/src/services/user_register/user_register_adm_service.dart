import '../../core/exceptions/service_exception.dart';
import '../../core/functionalProgramming/either.dart';
import '../../core/functionalProgramming/nil.dart';

abstract interface class UserRegisterAdmService {
    Future<Either<ServiceException, Nil>> execute(
    ({String name, String email, String password}) userData); 
}