import 'package:barbershop/src/core/ui/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/features/home/adm/widgets/home_employee_tile.dart';
import 'package:barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brown,
        child: const CircleAvatar(
          backgroundColor: ColorsConstants.white,
          maxRadius: 12,
          child: Icon(BarbershopIcons.addEmployee, color: ColorsConstants.brown,),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const HomeEmployeeTile(),
                childCount: 20)) //delegate é o cara que constroi o widget
        ],
      ),
    );
  }
}
