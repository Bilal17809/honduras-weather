import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/city_model.dart';
import '/core/theme/theme.dart';
import '/core/constants/constant.dart';
import '/core/services/services.dart';
import '/presentation/home/controller/home_controller.dart';
import '../../controller/cities_controller.dart';

class CityCard extends StatelessWidget {
  final CitiesController controller;
  final CityModel? city;

  const CityCard({super.key, required this.controller, this.city});

  @override
  Widget build(BuildContext context) {
    // final HomeController homeController = Get.find<HomeController>();

    return
    // final isCurrentlySelectedCity =
    //     homeController.selectedCity.value?.city == city.cityAscii;
    // final weather =
    //     controller.conditionController.allCitiesWeather[city.cityAscii];
    // final temp = weather?.temperature.round().toString() ?? '--';
    // final condition = weather?.condition ?? 'Loading...';
    // final airQuality = weather?.airQuality != null
    //     ? 'AQI ${weather!.airQuality!.calculatedAqi} - ${weather.airQuality!.category}'
    //     : 'Loading...';
    GestureDetector(
      onTap: () {},
      // onTap: () async {
      //   FocusScope.of(context).unfocus();
      //   // await controller.selectCity(city);
      //   if (controller.splashController.selectedCity.value != null &&
      //       LocationUtilsService.fromCityModel(
      //             controller.splashController.selectedCity.value!,
      //           ) ==
      //           LocationUtilsService.fromCityModel(city)) {
      //     Future.delayed(const Duration(milliseconds: 160), () {
      //       Get.back(result: city);
      //     });
      //   }
      // },
      child: Container(
        decoration: roundedDecor(context).copyWith(
          gradient: isDarkMode(context) ? null : kContainerGradient(context),
          color: isDarkMode(context)
              ? secondaryColorLight.withOpacity(0.35)
              : null,
          // border: isCurrentlySelectedCity
          //     ? Border.all(color: getSecondaryColor(context), width: 2)
          //     : null,
        ),
        padding: const EdgeInsets.all(kBodyHp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Lahore',
                    // city.city,
                    style: titleSmallStyle(
                      context,
                    ).copyWith(color: kWhite, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.my_location,
                  // isCurrentlySelectedCity
                  //     ? Icons.my_location
                  //     : Icons.location_on,
                  color: kWhite,
                  size: smallIcon(context),
                ),
              ],
            ),
            const SizedBox(height: kElementInnerGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '30°',
                  // '$temp°',
                  style: headlineMediumStyle(context).copyWith(color: kWhite),
                ),
                Text(
                  'Clear',
                  // condition,
                  style: bodyMediumStyle(context).copyWith(color: kWhite),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: kElementInnerGap),
            Text(
              'Aqi 60 - Good',
              // airQuality,
              style: bodyMediumStyle(context).copyWith(color: kWhite),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
