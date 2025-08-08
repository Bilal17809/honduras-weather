import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ad_manager/ad_manager.dart';
import '/core/animation/view/animated_bg_builder.dart';
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
  final ScrollController? scrollController;

  const DailyForecastView({
    super.key,
    required this.weatherIconPath,
    required this.condition,
    required this.temperature,
    required this.feelsLike,
    required this.precipitation,
    required this.humidity,
    required this.windSpeed,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InterstitialAdManager>().checkAndDisplayAd();
    });
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBgImageBuilder(),
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
                        onTap: () => Get.to(
                          () => const CitiesView(),
                          transition: Transition.fade,
                        ),
                        icon: Icons.add,
                        color: getIconColor(context),
                        size: secondaryIcon(context),
                      ),
                    ],
                  ),
                  HourlyForecastList(customScrollController: scrollController),
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
    );
  }
}
