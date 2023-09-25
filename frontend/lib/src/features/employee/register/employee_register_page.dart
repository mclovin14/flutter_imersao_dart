import 'dart:developer';

import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/helpers/notifications.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barberShopModelAsyncValue = ref.watch(getBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Notifications.showSuccess('Colaborador cadastrado com sucesso!', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Notifications.showError('Erro ao registrar colaborador!', context);
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar colaborador'),
        ),
        body: barberShopModelAsyncValue.when(
            data: (barbershopModel) {
              final BarbershopModel(:openingDays, :openingHours) =
                  barbershopModel;
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const AvatarWidget(),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                value: registerADM,
                                onChanged: (value) {
                                  setState(() {
                                    registerADM = !registerADM;
                                    employeeRegisterVm
                                        .setRegisterADM(registerADM);
                                  });
                                }),
                            const Expanded(
                              child: Text(
                                'Sou administrador e quero me cadastrar como colaborador',
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Offstage(
                          offstage: registerADM,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: nameEC,
                                validator: registerADM ? null : 
                                    Validatorless.required('Nome obrigatório!'),
                                decoration:
                                    const InputDecoration(label: Text('Nome')),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: emailEC,
                                validator: registerADM ? null : Validatorless.multiple([
                                  Validatorless.required('E-mail obrigatório!'),
                                  Validatorless.email('E-mail inválido!')
                                ]),
                                decoration: const InputDecoration(
                                    label: Text('E-mail')),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: passwordEC,
                                validator: registerADM ? null : Validatorless.multiple([
                                  Validatorless.required('Senha obrigatória!'),
                                  Validatorless.min(6,
                                      'Digite ao menos 6 caracteres para compor sua senha!')
                                ]),
                                decoration:
                                    const InputDecoration(label: Text('Senha')),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        WeekdaysPanel(
                            enabledDays: openingDays,
                            onDayPressed: (String day) {
                              employeeRegisterVm.addOrRemoveWorkDays(day);
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        HoursPanel(
                            startTime: 6,
                            endTime: 23,
                            enabledHours: openingHours,
                            onHourPressed: (int hour) {
                              employeeRegisterVm.addOrRemoveWorkHours(hour);
                            }),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            switch (formKey.currentState?.validate()) {
                              case (false || null):
                                Notifications.showError(
                                    'Campos inválidos', context);
                                break;
                              case true:
                                final EmployeeRegisterState(
                                  workDays: List(isNotEmpty: hasWorkDays),
                                  workHours: List(isNotEmpty: hasWorkHours)
                                ) = ref.watch(employeeRegisterVmProvider);
                                if (!hasWorkDays || !hasWorkHours) {
                                  Notifications.showError(
                                      'Por favor, selecione os dias da semana e o horário de atendimento',
                                      context);
                                  return;
                                }
                                final name = nameEC.text;
                                final email = emailEC.text;
                                final password = passwordEC.text;
                                employeeRegisterVm.register(
                                    name: name,
                                    email: email,
                                    password: password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                          ),
                          child: const Text('CADASTRAR COLABORADOR'),
                        )
                      ],
                    ),
                  ),
                ),
              ));
            },
            error: (error, stackTrace) {
              log('Erro ao carregar barbearia',
                  error: error, stackTrace: stackTrace);
              return const Center(
                child: Text('Erro ao carregar a página'),
              );
            },
            loading: () => const BarbershopLoader()));
  }
}
