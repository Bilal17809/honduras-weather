import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/core/common_widgets/common_widgets.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/common/app_exceptions.dart';
import '/core/services/map_service.dart';
import 'package:honduras_weather/presentation/home/controller/home_controller.dart';
import '/core/services/services.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      final selectedCity = homeController.selectedCity.value;
      final weather = selectedCity != null
          ? homeController.conditionService.allCitiesWeather[selectedCity
                .cityAscii]
          : null;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 3,
                  selectedCity != null
                      ? '${selectedCity.city}\n${weather?.region ?? 'N/a'}'
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
          ),
          GestureDetector(
            onTap: () =>
                selectedCity?.cityAscii.toLowerCase() !=
                    homeController.currentLocationCity?.cityAscii.toLowerCase()
                ? selectedCity != null
                      ? MapService.openMaps(
                          selectedCity.latitude,
                          selectedCity.longitude,
                        )
                      : SimpleToast.showCustomToast(
                          context: context,
                          message: AppExceptions().failMap,
                          type: ToastificationType.error,
                          icon: Icons.error_outline,
                          primaryColor: kRed,
                        )
                : null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              width: primaryIcon(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kBorderRadius),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    (selectedCity != null &&
                            selectedCity.cityAscii.toLowerCase() !=
                                homeController.currentLocationCity?.cityAscii
                                    .toLowerCase())
                        ? 'images/cities/${selectedCity.cityAscii.toLowerCase()}.jpg'
                        : 'images/map.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
