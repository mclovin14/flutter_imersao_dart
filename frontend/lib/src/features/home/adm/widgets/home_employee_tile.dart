import 'package:barbershop/src/core/ui/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  const HomeEmployeeTile({super.key});
  final bool networkImage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorsConstants.grey)),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: switch (networkImage) {
                    true => const NetworkImage('URL'),
                    false => const AssetImage(ImageConstansts.avatar)
                  } as ImageProvider,
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nome e Sobrenome',
                  style: TextStyle(
                      color: ColorsConstants.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {},
                        child: const Text('AGENDAR')),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {},
                        child: const Text('VER AGENDA')),
                        const Icon(BarbershopIcons.penEdit, color: ColorsConstants.brown, size: 16),
                        const Icon(BarbershopIcons.trash, color: ColorsConstants.red, size: 16),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
