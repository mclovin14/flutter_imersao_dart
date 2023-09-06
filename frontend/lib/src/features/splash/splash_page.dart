import 'dart:async';
import 'dart:developer';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/helpers/notifications.dart';
import 'package:barbershop/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double _getLogoAnimationWidth() {
    return 100 * _scale;
  }

  double _getLogoAnimationHeight() {
    return 120 * _scale;
  }

  var endAnimation = false;
  Timer? redirectTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

  void _redirect(String routeName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(const Duration(milliseconds: 300), (){
        _redirect(routeName);
      });
    } else {
      redirectTimer?.cancel();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(error: (error, stackTrace) {
        log('Erro ao validar login', error: error, stackTrace: stackTrace);
        Notifications.showError(
            'Erro ao valdar login!Por favor tente novamente mais tarde',
            context);
        _redirect('/auth/login');
      }, data: (data) {
        switch (data) {
          case SplashState.loggedADM:
            _redirect('/home/adm');
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/home/adm', (route) => false);
          case SplashState.loggedEmployee:
            _redirect('/home/employee');
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/home/employee', (route) => false);
          case _:
            _redirect('/auth/login');
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/auth/login', (route) => false);
        }
      });
    });
    return Scaffold(
        backgroundColor: Colors.black,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstansts.backgroundChair),
                opacity: 0.2,
                fit: BoxFit.cover),
          ),
          child: Center(
            child: AnimatedOpacity(
                duration: const Duration(seconds: 3),
                curve: Curves.easeIn,
                opacity: _animationOpacityLogo,
                onEnd: () {
                  setState(() {
                    endAnimation = true;
                  });
                },
                child: AnimatedContainer(
                    width: _getLogoAnimationWidth(),
                    height: _getLogoAnimationHeight(),
                    duration: const Duration(seconds: 3),
                    curve: Curves.linearToEaseOut,
                    child:
                        Image.asset(ImageConstansts.logo, fit: BoxFit.cover))),
          ),
        ));
  }
}
