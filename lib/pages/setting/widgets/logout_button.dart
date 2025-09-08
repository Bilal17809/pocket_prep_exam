
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          height: height * 0.06,
          width: width * 0.60,
          decoration: BoxDecoration(
            color: kBlue,
            borderRadius: BorderRadius.circular(22)
          ),
          child: Center(
            child: Text("Logout",style: context.textTheme.bodyLarge!.copyWith(
              color: kWhite,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}
