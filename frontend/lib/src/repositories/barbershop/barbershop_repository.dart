import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/functionalProgramming/nil.dart';
import 'package:barbershop/src/models/barbershop_model.dart';

import '../../core/functionalProgramming/either.dart';
import '../../models/user_model.dart';

abstract interface class BarbershopRepository {

 Future<Either<RepositoryException, Nil>> save(({
  String name,
  String email,
  List<String> openingDays,
  List<int> openingHours
 }) data);
  Future<Either<RepositoryException, BarbershopModel>> getBarbershop(UserModel userModel);
}