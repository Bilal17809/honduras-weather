import 'package:flutter/material.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';

class CurrentWeatherCard extends StatelessWidget {
  final String weatherIconPath;
  final String condition;
  final int temperature;
  final int feelsLike;
  final String precipitation;
  final String humidity;
  final String windSpeed;

  const CurrentWeatherCard({
    super.key,
    required this.weatherIconPath,
    required this.condition,
    required this.temperature,
    required this.feelsLike,
    required this.precipitation,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: roundedDecor(context),
      padding: const EdgeInsets.symmetric(
        vertical: kElementInnerGap,
        horizontal: kElementWidthGap,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(
                      height: primaryIcon(context),
                      child: Image.asset(weatherIconPath),
                    ),
                    Text(
                      maxLines: 2,
                      condition,
                      style: bodyLargeStyle(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: kElementInnerGap),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: primaryIcon(context),
                      child: Text(
                        '$temperature°',
                        style: headlineLargeStyle(context),
                      ),
                    ),
                    Text(
                      'Feels like $feelsLike°',
                      style: bodyLargeStyle(context),
                    ),
                    const SizedBox(height: kElementInnerGap),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: kElementInnerGap),
          Container(
            decoration: roundedInnerDecor(context),
            padding: const EdgeInsets.symmetric(
              vertical: kElementInnerGap,
              horizontal: kElementWidthGap,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherStat(
                  iconPath: 'images/precip.png',
                  value: precipitation,
                  label: 'Precipitation',
                ),
                WeatherStat(
                  iconPath: 'images/humidity.png',
                  value: humidity,
                  label: 'Humidity',
                ),
                WeatherStat(
                  iconPath: 'images/wind.png',
                  value: windSpeed,
                  label: 'Wind',
                ),
              ],
            ),
          ),
          const SizedBox(height: kElementInnerGap),
        ],
      ),
    );
  }
}
