import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/helpers/form.helper.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
import 'package:barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/notifications.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
          break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/employee', (route) => false);
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Notifications.showError(errorMessage, context);
          break;
        case LoginState(status: LoginStateStatus.error):
          Notifications.showError(
              'Erro ao realizar login! Por favor, tente novamente mais tarde.',
              context);
          break;
      }
    });
    return Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: formKey,
          child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstansts.backgroundChair),
                    opacity: 0.2,
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImageConstansts.logo),
                              const SizedBox(
                                height: 45,
                              ),
                              TextFormField(
                                onTapOutside: (_) => context.unfocus(),
                                validator: Validatorless.multiple([
                                  Validatorless.required('Email obrigatória!'),
                                  Validatorless.email('Email inválido!')
                                ]),
                                controller: emailEC,
                                decoration: const InputDecoration(
                                    label: Text('E-mail'),
                                    hintText: 'E-mail',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        TextStyle(color: ColorsConstants.black),
                                    hintStyle: TextStyle(
                                        color: ColorsConstants.black)),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                onTapOutside: (_) => context.unfocus(),
                                validator: Validatorless.multiple([
                                  Validatorless.required('Senha obrigatória!'),
                                  Validatorless.min(
                                      6, 'Digite ao menos 6 caracteres!')
                                ]),
                                obscureText: true,
                                controller: passwordEC,
                                decoration: const InputDecoration(
                                    label: Text('Senha'),
                                    hintText: 'Senha',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        TextStyle(color: ColorsConstants.black),
                                    hintStyle: TextStyle(
                                        color: ColorsConstants.black)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                      color: ColorsConstants.brown,
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(56)),
                                  onPressed: () {
                                    switch (formKey.currentState?.validate()) {
                                      case (false || null):
                                        Notifications.showError(
                                            'Campos inválidos', context);
                                        break;
                                      case true:
                                        login(emailEC.text, passwordEC.text);
                                    }
                                  },
                                  child: const Text('ACESSAR')),
                            ],
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/auth/register/user', (route) => false);
                                }, //traz o poder do botão se mudar nada no seu componente filho
                                child: const Text(
                                  'Criar Conta',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
