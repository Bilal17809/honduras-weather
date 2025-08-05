import 'package:flutter/material.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';
import 'forecast_row.dart';

class ForecastContainer extends StatelessWidget {
  const ForecastContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kBodyHp),
      decoration: roundedForecastDecor(context),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(top: mobileHeight(context) * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  7,
                  (index) => ForecastRow(
                    day: 'Monday',
                    iconUrl:
                        'https://cdn.weatherapi.com/weather/64x64/day/116.png',
                    maxTemp: 30,
                    minTemp: 22,
                    condition: 'Partly cloudy',
                  ),
                ),

                // if (controller.hasForecastData)
                //   ...controller.forecastData.map(
                //     (dayData) => ForecastRow(
                //       day: dayData['day'] ?? '',
                //       iconUrl: dayData['iconUrl'] ?? '',
                //       maxTemp: dayData['temp']?.round() ?? 0,
                //       minTemp: dayData['minTemp']?.round() ?? 0,
                //       condition: dayData['condition'] ?? '',
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
