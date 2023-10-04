import 'package:barbershop/src/core/ui/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final bool hideUploadButton;
  const AvatarWidget({super.key, this.hideUploadButton = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(ImageConstansts.avatar)),
              )),
          Positioned(
            bottom: 5,
            right: 5,
            child: Offstage(
              offstage: hideUploadButton,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorsConstants.white,
                    border: Border.all(color: ColorsConstants.brown, width: 4),
                    shape: BoxShape.circle),
                child: const Icon(
                  BarbershopIcons.addEmployee,
                  size: 20,
                  color: ColorsConstants.brown,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
