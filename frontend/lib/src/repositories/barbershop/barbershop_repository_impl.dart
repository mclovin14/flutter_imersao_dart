import 'dart:developer';

import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/either.dart';
import 'package:barbershop/src/core/functionalProgramming/nil.dart';
import 'package:barbershop/src/core/restClient/rest_client.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:dio/dio.dart';
import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, BarbershopModel>> getBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) =
            await restClient.auth.get('/barbershop', queryParameters: {
          'user_id':
              '#userAuthRef' //no json rest services ele substituira essa tag pela do usuário logado
        });
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee(): //aqui o usermoldel passa ser um UserModelEmployee por conta a inteligência do dart (auto promoções de tipo)
        final Response(:data) =
            await restClient.auth.get('/barbershop/${userModel.barbershopId}');
        return Success(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {

      try {
  await restClient.auth.post('/barbershop', data: {
    'user_id': '#userAuthRef',
    'name': data.name,
    'email': data.email,
    'opening_days': data.openingDays,
    'opening_hours': data.openingHours,
  });
  return Success(nil);
} on DioException catch (e, s) {
  log('Erro ao registrar barbearia', error: e, stackTrace: s);
  return Failure(RepositoryException(message: 'Erro ao registrar barbearia'));
}
  }
}
