import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/presentation/home/controller/home_controller.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';
import '/core/constants/constant.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final weatherModel =
        Get.find<ConditionService>().currentLocationWeather.value;
    return Obx(() {
      final currentCity = homeController.currentLocationCity;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentCity != null
                    ? '${currentCity.city}\n${weatherModel?.region ?? 'N/a'}'
                    : 'Error Fetching City',

                style: headlineSmallStyle(context),
              ),
              Text(
                DateTimeService.getFormattedCurrentDate(),
                style: bodyLargeStyle(
                  context,
                ).copyWith(color: primaryText(context)),
              ),
            ],
          ),
          SizedBox(
            width: primaryIcon(context),
            child: Image.asset('images/map.png', fit: BoxFit.contain),
          ),
        ],
      );
    });
  }
}
