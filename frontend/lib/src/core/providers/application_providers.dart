import 'package:barbershop/src/core/restClient/rest_client.dart';
import 'package:barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:barbershop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/barbershop_model.dart';
import '../../models/user_model.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../services/user_login/user_login_service.dart';
import '../../services/user_login/user_login_service_impl.dart';
import '../functionalProgramming/either.dart';


part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getSession(GetSessionRef ref) async {
  final result = await ref.watch(userRepositoryProvider).getSession();
  return switch(result){
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
  BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));


@Riverpod(keepAlive: true)
Future<BarbershopModel> getBarbershop(GetBarbershopRef ref) async {
  final userModel = await ref.watch(getSessionProvider.future); //extrai o futuro, não excutando a consulta para o backend novamente

  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getBarbershop(userModel);

  return switch(result){
    Success(value: final barbeshop) => barbeshop,
    Failure(:final exception) => throw exception
  };
 
}