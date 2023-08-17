import 'dart:developer';
import 'dart:io';

import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';

import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/restClient/rest_client.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  
  final RestClient restClient;
  UserRepositoryImpl({required this.restClient});


  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
    try {
  final Response(:data) = await restClient.unAuth.post('/auth', data:{
    'email': email,
    'password': password
  });
  
  final String token = data['access_token'] as String;

  return Success(token);
} on DioException catch (e, s) {
  if(e.response != null){
    final Response(:statusCode) = e.response!;
    if(statusCode == HttpStatus.forbidden){
       log('Login ou senha inválidos', error: e, stackTrace: s);
       return Failure(AuthUnauthorizedException(message: 'Login ou senha inválidos!'));
    }
  }
  log('Erro ao realizar login', error: e, stackTrace: s);
  return Failure(AuthError(message: 'Erro ao realizar login!'));
}

  }

  @override
  Future<Either<RepositoryException, UserModel>> getSession() async {
     try {
  final Response(:data) = await restClient.auth.get('/me');
  return Success(UserModel.fromMap(data));
} on DioException catch (e, s) {
  log('Erro ao buscar usuário logado', error: e, stackTrace: s);
  return Failure(RepositoryException(message: 'Erro ao buscar usuário Logado'));
} on ArgumentError catch (e, s) {
  log('Invalid json', error: e, stackTrace: s);
  return Failure(RepositoryException(message: e.message));
}
  }
}
