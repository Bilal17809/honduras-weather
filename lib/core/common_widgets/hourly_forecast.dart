import 'package:flutter/material.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';

class HourlyForecast extends StatelessWidget {
  final String day;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;

  const HourlyForecast({
    super.key,
    required this.day,
    required this.isSelected,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mobileWidth(context) * 0.2,
      margin: EdgeInsets.only(
        left: isFirst ? kBodyHp : 0,
        right: isLast ? kBodyHp : kElementGap,
      ),
      padding: const EdgeInsets.symmetric(vertical: kBodyHp),
      decoration: roundedSelectionDecoration(context, isSelected: isSelected),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '12:00',
                style: bodyMediumStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? textWhiteColor : coloredText(context),
                ),
              ),
            ),
            const SizedBox(height: kElementInnerGap),
            Icon(
              Icons.wb_sunny,
              size: mediumIcon(context),
              color: getIconColor(context),
            ),
            const SizedBox(height: kElementInnerGap),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '30°',
                style: bodyMediumStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? textWhiteColor : coloredText(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
