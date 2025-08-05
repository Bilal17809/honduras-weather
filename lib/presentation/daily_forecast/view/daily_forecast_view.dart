import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/presentation/cities/view/cities_view.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constant.dart';
import 'widgets/forecast_container.dart';
import 'widgets/weather_card.dart';

class DailyForecastView extends StatelessWidget {
  const DailyForecastView({super.key});

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
                      child: const CurrentWeatherCard(),
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
