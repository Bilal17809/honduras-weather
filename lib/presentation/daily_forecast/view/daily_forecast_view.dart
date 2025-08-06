import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/presentation/cities/view/cities_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constant.dart';
import 'widgets/forecast_container.dart';
import 'widgets/weather_card.dart';

class DailyForecastView extends StatelessWidget {
  final String weatherIconPath;
  final String condition;
  final int temperature;
  final int feelsLike;
  final String precipitation;
  final String humidity;
  final String windSpeed;

  const DailyForecastView({
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: mobileHeight(context) * 0.5,
              left: 0,
              right: 0,
              bottom: 0,
              child: const ForecastContainer(),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Column(
                  children: [
                    TitleBar(
                      title: 'Next 7 Days',
                      actions: [
                        IconActionButton(
                          onTap: () => Get.to(() => const CitiesView()),
                          icon: Icons.add,
                          color: getIconColor(context),
                          size: secondaryIcon(context),
                        ),
                      ],
                    ),
                    const HourlyForecastList(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kBodyHp * 2,
                        vertical: kElementGap,
                      ),
                      child: CurrentWeatherCard(
                        weatherIconPath: weatherIconPath,
                        condition: condition,
                        temperature: temperature,
                        feelsLike: feelsLike,
                        precipitation: precipitation,
                        humidity: humidity,
                        windSpeed: windSpeed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
