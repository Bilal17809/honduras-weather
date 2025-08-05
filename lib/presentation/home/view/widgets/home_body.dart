import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/core/services/condition_service.dart';
import 'package:honduras_weather/presentation/daily_forecast/view/daily_forecast_view.dart';
import 'package:honduras_weather/presentation/home/controller/home_controller.dart';
import '/core/animation/view/animated_weather_icon.dart';
import '/core/utils/weather_utils.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/cities/view/cities_view.dart';
import 'top_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final conditionService = Get.find<ConditionService>();
    return Obx(() {
      final selectedCity = homeController.selectedCity.value;
      final weather = selectedCity != null
          ? homeController.conditionService.allCitiesWeather[selectedCity
                .cityAscii]
          : null;

      final temp = weather?.temperature.round().toString() ?? '--';
      return Column(
        children: [
          TitleBar(
            title: '',
            useBackButton: false,
            actions: [
              IconActionButton(
                onTap: () => Get.to(() => CitiesView()),
                icon: Icons.add,
                color: getIconColor(context),
                size: secondaryIcon(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kBodyHp * 2),
            child: Column(
              children: [
                const TopSection(),
                const SizedBox(height: kElementGap),
                Container(
                  decoration: roundedDecor(context),
                  padding: const EdgeInsets.symmetric(
                    vertical: kElementInnerGap,
                    horizontal: kElementWidthGap,
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
                                condition: weather.condition,
                              ),
                            ),
                            Text(
                              maxLines: 2,
                              softWrap: true,
                              conditionService.condition,
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
                                '$temp°',
                                style: headlineLargeStyle(context),
                              ),
                            ),
                            Text(
                              'Feels like ${weather.feelsLike.round()}°',
                              style: bodyLargeStyle(context),
                            ),
                            const SizedBox(height: kElementInnerGap),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kElementGap),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WeatherStat(
                        iconPath: 'images/precip.png',
                        value: conditionService.chanceOfRain,
                        label: 'Precipitation',
                      ),
                      WeatherStat(
                        iconPath: 'images/humidity.png',
                        value: conditionService.humidity,
                        label: 'Humidity',
                      ),
                      WeatherStat(
                        iconPath: 'images/wind.png',
                        value: conditionService.windSpeed,
                        label: 'Wind',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kElementGap),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Today', style: titleBoldMediumStyle(context)),
                      GestureDetector(
                        onTap: () => Get.to(() => DailyForecastView()),
                        child: Text(
                          'Next 7 Days >',
                          style: bodyLargeStyle(
                            context,
                          ).copyWith(color: primaryText(context)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kElementGap),
          SizedBox(
            height: mobileHeight(context) * 0.14,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 24,
              itemBuilder: (context, index) {
                return HourlyForecast(
                  day: 'Monday',
                  isSelected: 'Monday' == 'Monday',
                  isFirst: index == 0,
                  isLast: index == 6,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
