import 'package:flutter/material.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class UpgradeButton extends StatelessWidget {
  const UpgradeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 52),
        child: SizedBox(
          height: 60,
          child: GestureDetector(
            onTap: (){
            },
            child: Card(
              color: lightSkyBlue,
              child:
                Center(child: Text("Upgrade for all quiz modes.",style: TextStyle(color: kWhite,fontSize: 18),))
            ),
          ),
        ),
      )
    );
  }
}
