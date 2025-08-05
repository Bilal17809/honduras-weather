import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/presentation/daily_forecast/view/widgets/forecast_row.dart';
import '../../home/view/widgets/home_body.dart';
import '/core/theme/theme.dart';
import '/presentation/cities/view/cities_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/home/view/widgets/hourly_forecast.dart';
import '/core/constants/constant.dart';

class DailyForecastView extends StatelessWidget {
  const DailyForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mobileHeight(context) * 0.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Expanded(flex: 3, child: const ForecastContainer()),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  TitleBar(
                    title: 'Next 7 Days',
                    actions: [
                      IconActionButton(
                        onTap: () => Get.to(() => CitiesView()),
                        icon: Icons.add,
                        color: getIconColor(context),
                        size: secondaryIcon(context),
                      ),
                    ],
                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kBodyHp * 2,
                      vertical: kElementGap,
                    ),
                    child: Container(
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
                                    child: Image.asset(
                                      'images/weather_icon.png',
                                    ),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: primaryIcon(context),
                                    child: Text(
                                      '27°',
                                      style: headlineLargeStyle(context),
                                    ),
                                  ),
                                  Text(
                                    'Feels like 32°',
                                    style: bodyLargeStyle(context),
                                  ),
                                  const SizedBox(height: kElementInnerGap),
                                ],
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

class ForecastContainer extends StatelessWidget {
  const ForecastContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(kBodyHp),
      decoration: roundedForecastDecor(context),
      child: SizedBox(
        height: 302,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mobileHeight(context) * 0.1),
              ...List.generate(
                9,
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
    );
  }
}
