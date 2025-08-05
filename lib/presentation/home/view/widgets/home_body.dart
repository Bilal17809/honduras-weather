import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/presentation/daily_forecast/view/daily_forecast_view.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/cities/view/cities_view.dart';
import 'hourly_forecast.dart';
import 'top_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Text('Feels like 32°', style: bodyLargeStyle(context)),
                        const SizedBox(height: kElementInnerGap),
                      ],
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
  }
}

class WeatherStat extends StatelessWidget {
  final String iconPath;
  final String value;
  final String label;

  const WeatherStat({
    super.key,
    required this.iconPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: mediumIcon(context),
          child: Image.asset(iconPath, fit: BoxFit.contain),
        ),
        Text(
          value,
          style: titleSmallStyle(context).copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: bodyMediumStyle(context)),
      ],
    );
  }
}
