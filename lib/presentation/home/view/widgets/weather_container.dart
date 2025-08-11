import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/core/animation/view/animated_weather_icon.dart';
import '/core/constants/constants.dart';
import '/core/utils/weather_utils.dart';
import '/core/theme/theme.dart';
import '/data/models/weather_model.dart';

class WeatherContainer extends StatelessWidget {
  final WeatherModel? weather;
  final String temp;

  const WeatherContainer({
    super.key,
    required this.weather,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    if (weather == null) return const SizedBox();

    return Container(
      decoration: roundedDecor(context),
      padding: const EdgeInsets.symmetric(
        vertical: kGap,
        horizontal: kElementGap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              children: [
                SizedBox(
                  height: primaryIcon(context),
                  child: AnimatedWeatherIcon(
                    imagePath: WeatherUtils.getWeatherIconPath(
                      WeatherUtils.getWeatherIcon(weather!.code),
                    ),
                    condition: weather!.condition,
                  ),
                ),
                Text(
                  maxLines: 2,
                  softWrap: true,
                  weather!.condition,
                  style: bodyLargeStyle(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(kGap),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: primaryIcon(context),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('$temp°', style: headlineLargeStyle(context)),
                  ),
                ),
                Text(
                  'Feels like ${weather!.feelsLike.round()}°',
                  style: bodyLargeStyle(context),
                ),
                const Gap(kGap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
