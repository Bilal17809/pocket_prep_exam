import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget {
  final bool isCenter;
  final bool isBack;
  const MainAppbar({
    super.key,
    this.isBack=false,
    this.isCenter=false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: isCenter,
        automaticallyImplyLeading: isBack,
      ),
    );
  }
}
