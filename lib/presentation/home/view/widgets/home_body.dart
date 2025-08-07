import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/data/models/weather_model.dart';
import 'package:honduras_weather/presentation/daily_forecast/view/daily_forecast_view.dart';
import 'package:honduras_weather/presentation/home/controller/home_controller.dart';
import '../../../daily_forecast/controller/daily_forecast_controller.dart';
import '/core/services/services.dart';
import '/core/utils/weather_utils.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/cities/view/cities_view.dart';
import 'home_header.dart';
import 'weather_container.dart';

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
                onTap: () {
                  Get.to(
                    () => const CitiesView(),
                    transition: Transition.fadeIn,
                  );
                },
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
                const HomeHeader(),
                const SizedBox(height: kElementGap),
                WeatherContainer(weather: weather, temp: temp),
                const SizedBox(height: kElementGap),
                _WeatherRow(conditionService, weather),
                const SizedBox(height: kElementGap),
                _TodayRow(weather: weather, conditionService: conditionService),
              ],
            ),
          ),
          const SizedBox(height: kElementGap),
          const HourlyForecastList(),
        ],
      );
    });
  }
}

class _WeatherRow extends StatelessWidget {
  final WeatherModel? weather;
  final ConditionService conditionService;
  const _WeatherRow(this.conditionService, this.weather);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class _TodayRow extends StatelessWidget {
  final WeatherModel? weather;
  final ConditionService conditionService;

  const _TodayRow({required this.weather, required this.conditionService});

  @override
  Widget build(BuildContext context) {
    final dailyForecastController = Get.find<DailyForecastController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Today', style: titleBoldMediumStyle(context)),
          GestureDetector(
            onTap: () {
              Get.to(
                transition: Transition.fade,
                () => DailyForecastView(
                  weatherIconPath: WeatherUtils.getWeatherIconPath(
                    WeatherUtils.getWeatherIcon(weather!.code),
                  ),
                  condition: weather!.condition,
                  temperature: weather!.temperature.round(),
                  feelsLike: weather!.feelsLike.round(),
                  precipitation: conditionService.chanceOfRain,
                  humidity: conditionService.humidity,
                  windSpeed: conditionService.windSpeed,
                  scrollController: dailyForecastController.scrollController,
                ),
              );
            },
            child: Text(
              'Next 7 Days >',
              style: bodyLargeStyle(
                context,
              ).copyWith(color: primaryText(context)),
            ),
          ),
        ],
      ),
    );
  }
}
