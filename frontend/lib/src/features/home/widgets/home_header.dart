import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool hideFilter;
  const HomeHeader({super.key, this.hideFilter = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getBarbershopProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32)),
          color: ColorsConstants.black,
          image: DecorationImage(
              image: AssetImage(ImageConstansts.backgroundChair),
              fit: BoxFit.cover,
              opacity: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          barbershop.maybeWhen(
            data: (barbershopData) {
              return Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xffbdbdbd),
                    child: SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      barbershopData.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ColorsConstants.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Expanded(
                    child: Text(
                      'editar',
                      style: TextStyle(
                          color: ColorsConstants.brown,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        ref.read(homeAdmVmProvider.notifier).logout();
                      },
                      icon: const Icon(
                        BarbershopIcons.exit,
                        color: ColorsConstants.brown,
                        size: 32,
                      ))
                ],
              );
            },
            orElse: () {
              // O maybeWhen é usado para deixar os dados nao obirgatórios.O orelse ja irá tratar o erro Aula4 hora 1:15
              return const Center(
                child: BarbershopLoader(),
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Bem vindo',
            style: TextStyle(
                color: ColorsConstants.white,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agende um Cliente',
            style: TextStyle(
                color: ColorsConstants.white,
                fontWeight: FontWeight.w600,
                fontSize: 40),
          ),
          Offstage(
            offstage: hideFilter, //ele tira o elemento da tela como um todo
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                  label: Text('Buscar Colaborador'),
                  suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Icon(
                        BarbershopIcons.search,
                        color: ColorsConstants.brown,
                        size: 26,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
