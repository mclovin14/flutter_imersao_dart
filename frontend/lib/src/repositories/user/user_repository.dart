import 'dart:ffi';

import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/functionalProgramming/nil.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> getSession();

  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({
        String name,
        String email,
        String password
      }) userData); // isso aqui é um novo padrão do dart, chamado de record. Usado para substitur as classes de DTO

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId);

  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({List<String> workDays, List<int> workHours}) userData);

  Future<Either<RepositoryException, Nil>> registerEmployee(
      ({
        int barbershopId,
        String name,
        String email,
        String password,
        List<String> workDays,
        List<int> workHours
      }) userData);
}
