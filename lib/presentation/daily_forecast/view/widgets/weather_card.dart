import 'package:flutter/material.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key});

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
              Column(
                children: [
                  SizedBox(
                    height: primaryIcon(context),
                    child: Image.asset('images/weather_icon.png'),
                  ),
                  Text(
                    'Thunderstorm',
                    style: bodyLargeStyle(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: kElementInnerGap),
                ],
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: primaryIcon(context),
                      child: Text('27°', style: headlineLargeStyle(context)),
                    ),
                    Text('Feels like 32°', style: bodyLargeStyle(context)),
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
              children: const [
                WeatherStat(
                  iconPath: 'images/precip.png',
                  value: '30%',
                  label: 'Precipitation',
                ),
                WeatherStat(
                  iconPath: 'images/humidity.png',
                  value: '20%',
                  label: 'Humidity',
                ),
                WeatherStat(
                  iconPath: 'images/wind.png',
                  value: '12km/h',
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
