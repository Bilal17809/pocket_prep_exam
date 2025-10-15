import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';


class EmptyStateWidget extends StatelessWidget {
  final String type;
  const EmptyStateWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(type.toLowerCase());

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: kWhite,
              child: Icon(config.icon, color: config.color, size: 32),
            ),
            const SizedBox(height: 08),
            Text(
              config.message,
              style:context.textTheme.titleMedium!.copyWith(
              )
            ),
            const SizedBox(height: 2),
            Text(
             config.message2,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!.copyWith(
                color: grey

              )
            ),
          ],
        ),
      ),
    );
  }

  _EmptyConfig _getConfig(String type) {
    switch (type) {
      case 'correct':
        return _EmptyConfig(
          icon: Icons.done_rounded,
          color: Colors.green,
          message: "No Correct Questions",
          message2: "Let's start studying!"
        );
      case 'incorrect':
        return _EmptyConfig(
          icon: Icons.cancel_rounded,
          color: Colors.redAccent,
          message: "0 Incorrect Questions",
          message2: "Impressive?"
        );
      case 'flagged':
      case 'skipped':
        return _EmptyConfig(
          icon: Icons.flag_outlined,
          color: Colors.orangeAccent,
          message: "No Flagged Questions",
          message2: "Tap the flag at the bottom of any\nquestion and you can review theme here."
        );
      case 'All':
        return _EmptyConfig(
          icon: Icons.bookmark_border_rounded,
          color: Colors.blueAccent,
          message: "No Bookmarked Questions",
          message2: ""
        );
      default:
        return _EmptyConfig(
          icon: Icons.inbox_outlined,
          color: grey,
          message: "No $type Questions",
          message2: ""
        );
    }
  }
}

class _EmptyConfig {
  final IconData icon;
  final Color color;
  final String message;
   final String message2;
  _EmptyConfig({
    required this.icon,
    required this.color,
    required this.message,
    required this.message2
  });
}
