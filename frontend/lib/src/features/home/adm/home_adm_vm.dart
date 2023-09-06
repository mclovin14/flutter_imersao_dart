import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/home/adm/home_adm_state.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/functionalProgramming/either.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final userRepository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.read(getBarbershopProvider.future);

    final employeesResult = await userRepository.getEmployees(barbershopId);
    switch (employeesResult) {
      case Success(value: final employees):
        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
