import 'package:flutter/material.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';
import '/core/constants/constant.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('London\nUnited Kingdom', style: headlineSmallStyle(context)),
            Text(
              DateTimeService.getFormattedCurrentDate(),
              style: bodyLargeStyle(
                context,
              ).copyWith(color: primaryText(context)),
            ),
          ],
        ),
        SizedBox(
          width: primaryIcon(context),
          child: Image.asset('images/map.png', fit: BoxFit.contain),
        ),
      ],
    );
  }
}
