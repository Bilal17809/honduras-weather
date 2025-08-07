import 'package:flutter/material.dart';
import 'theme.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColorLight,
    scaffoldBackgroundColor: lightBgColor,
    colorScheme: ColorScheme.light(
      primary: primaryColorLight,
      secondary: secondaryColorLight,
      surface: lightBgColor,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: textWhiteColor),
      bodyMedium: TextStyle(color: textWhiteColor),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: darkBgColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColorDark,
      secondary: secondaryColorDark,
      surface: darkBgColor,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: textBlackColor),
      bodyMedium: TextStyle(color: textGreyColor),
    ),
  );
}

//decoration
BoxDecoration roundedDecor(BuildContext context) => BoxDecoration(
  gradient: kContainerGradient(context),
  borderRadius: BorderRadius.circular(24),
  boxShadow: [
    BoxShadow(
      color: isDarkMode(context)
          ? darkBgColor.withValues(alpha: 0.3)
          : getPrimaryColor(context).withValues(alpha: 0.3),
      blurRadius: 6,
      spreadRadius: 1,
      offset: Offset(0, 2),
    ),
  ],
);

BoxDecoration roundedInnerDecor(BuildContext context) => BoxDecoration(
  color: kWhite.withValues(alpha: 0.5),
  borderRadius: BorderRadius.circular(24),
  boxShadow: [
    BoxShadow(
      color: isDarkMode(context)
          ? darkBgColor.withValues(alpha: 0.3)
          : kWhite.withValues(alpha: 0.1),
      blurRadius: 6,
      spreadRadius: 1,
      offset: Offset(0, 2),
    ),
  ],
);

BoxDecoration roundedForecastDecor(BuildContext context) => BoxDecoration(
  color: isDarkMode(context)
      ? secondaryColorLight.withValues(alpha: 0.9)
      : kWhite.withValues(alpha: 0.9),
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(100),
    topLeft: Radius.circular(100),
  ),
);

BoxDecoration roundedSelectionDecoration(
  BuildContext context, {
  required bool isSelected,
}) {
  final isDark = isDarkMode(context);

  return BoxDecoration(
    color: isDark
        ? (isSelected
              ? kWhite.withValues(alpha: 0.5)
              : kWhite.withValues(alpha: 0.25))
        : (isSelected
              ? secondaryColorLight.withValues(alpha: 0.9)
              : unselectedColor),
    borderRadius: BorderRadius.circular(35),
    boxShadow: [
      BoxShadow(
        color: isDark
            ? darkBgColor.withValues(alpha: 0.3)
            : primaryColorLight.withValues(alpha: 0.3),
        blurRadius: 6,
        spreadRadius: 1,
        offset: Offset(0, 2),
      ),
    ],
  );
}

Color getPrimaryColor(BuildContext context) =>
    isDarkMode(context) ? primaryColorDark : primaryColorLight;

Color getSecondaryColor(BuildContext context) => isDarkMode(context)
    ? secondaryColorDark.withValues(alpha: 0.1)
    : secondaryColorLight;

Color getSearchBgColor(BuildContext context) => isDarkMode(context)
    ? secondaryColorDark.withValues(alpha: 0.1)
    : primaryColorLight;

Color getBgColor(BuildContext context) =>
    isDarkMode(context) ? darkBgColor : lightBgColor;

Color secondaryText(BuildContext context) =>
    isDarkMode(context) ? textWhiteColor : textBlackColor;

Color primaryText(BuildContext context) =>
    isDarkMode(context) ? textWhiteColor : textWhiteColor;

Color coloredText(BuildContext context) =>
    isDarkMode(context) ? textWhiteColor : textPrimaryColor;
//
// Color coloredText2(BuildContext context) =>
//     isDarkMode(context) ? textWhiteColor : textSecondaryColor;

Color getIconColor(BuildContext context) =>
    isDarkMode(context) ? kWhite : kWhite;

LinearGradient kGradient(BuildContext context) {
  return LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: isDarkMode(context)
        ? [kWhite.withValues(alpha: 0.08), kWhite.withValues(alpha: 0.06)]
        : [primaryColorLight, secondaryColorLight],
    stops: [0.3, 0.95],
  );
}

LinearGradient kContainerGradient(BuildContext context) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: isDarkMode(context)
        ? [kWhite.withValues(alpha: 0.4), kWhite.withValues(alpha: 0.2)]
        : [primaryColorLight, secondaryColorLight],
    stops: [0.05, 0.75],
  );
}

LinearGradient kSelectedGradient(BuildContext context) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: isDarkMode(context)
        ? [kWhite.withValues(alpha: 0.08), kWhite.withValues(alpha: 0.06)]
        : [selectedLightColor, selectedDarkColor],
    stops: [0.05, 0.5],
  );
}
