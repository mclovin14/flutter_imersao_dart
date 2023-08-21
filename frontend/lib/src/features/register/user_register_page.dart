import 'package:barbershop/src/core/ui/helpers/form.helper.dart';
import 'package:barbershop/src/features/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/helpers/notifications.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
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
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);
    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
          Notifications.showError(
              'Erro ao registrar usuário administrador', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        leading: const Icon(Icons.arrow_back_sharp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: nameEC,
                validator: Validatorless.required('Nome obrigatório'),
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: emailEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Email obrigatório'),
                  Validatorless.email('E-mail inválido!')
                ]),
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: passwordEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(
                      6, 'Digite ao menos 6 digitos para sua senha')
                ]),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                validator: Validatorless.multiple([
                  Validatorless.required('Confirmar Senha obrigatória'),
                  Validatorless.compare(passwordEC, 'Senhas diferentes')
                ]),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Confirmar Senha'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Notifications.showError('Formulário inválido', context);
                        break;
                      case true:
                        userRegisterVm.register(
                            name: nameEC.text,
                            email: emailEC.text,
                            password: passwordEC.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(56),
                  ),
                  child: Text('CRIAR CONTA'))
            ],
          ),
        )),
      ),
    );
  }
}
