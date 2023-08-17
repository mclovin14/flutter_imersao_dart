import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> getSession();
}