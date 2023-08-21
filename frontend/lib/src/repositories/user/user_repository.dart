import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/functionalProgramming/nil.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> getSession();

  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String name, String email, String password}) userData); // isso aqui é um novo padrão do dart, chamado de record. Usado para substitur as classes de DTO
}
