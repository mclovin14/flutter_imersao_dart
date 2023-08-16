import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_image_chair.jpg'),
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
                            Image.asset('assets/images/imgLogo.png'),
                            const SizedBox(
                              height: 45,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('E-mail'),
                                  hintText: 'E-mail',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle:
                                      TextStyle(color: ColorsConstants.black),
                                  hintStyle:
                                      TextStyle(color: ColorsConstants.black)),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Senha'),
                                  hintText: 'Senha',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle:
                                      TextStyle(color: ColorsConstants.black),
                                  hintStyle:
                                      TextStyle(color: ColorsConstants.black)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(color: ColorsConstants.brown, fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                               height: 24,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56)
                              ),
                              onPressed: (){},
                               child: const Text('ACESSAR')),
                          ],
                        ),
                        const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Criar Conta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}