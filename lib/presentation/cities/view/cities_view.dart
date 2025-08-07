import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import 'widgets/city_card.dart';
import 'widgets/current_location_card.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constant.dart';
import '../controller/cities_controller.dart';
/*
if padding fromLTRB than use static number/
themes check? create getter function in extension
just use here.
*/
class CitiesView extends StatelessWidget {
  const CitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final CitiesController controller = Get.find();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  TitleBar(title: 'Select City'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      kBodyHp,
                      kBodyHp,
                      kBodyHp,
                      0,
                    ),
                    child: Obx(() {
                      final dark = isDarkMode(context);
                      return SearchBarField(
                        controller: controller.searchController,
                        onSearch: (value) => controller.searchCities(value),
                        backgroundColor: dark
                            ? kWhite.withValues(alpha: 0.3)
                            : getPrimaryColor(context),
                        borderColor: controller.hasSearchError.value
                            ? kRed
                            : getSecondaryColor(context),
                        iconColor: controller.hasSearchError.value
                            ? kRed
                            : getSecondaryColor(context),
                        textColor: secondaryText(context),
                      );
                    }),
                  ),
                  Obx(
                    () => controller.hasSearchError.value
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(
                              kBodyHp,
                              kElementInnerGap,
                              kBodyHp,
                              0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: kRed,
                                  size: smallIcon(context),
                                ),
                                const SizedBox(width: kElementWidthGap),
                                Expanded(
                                  child: Text(
                                    controller.searchErrorMessage.value,
                                    style: bodySmallStyle(context).copyWith(
                                      color: kRed,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      kBodyHp,
                      kBodyHp,
                      kBodyHp,
                      0,
                    ),
                    child: CurrentLocationCard(controller: controller),
                  ),
                  Expanded(
                    child: Obx(() {
                      final cities = controller.filteredCities;
                      if (cities.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          kBodyHp,
                          0,
                          kBodyHp,
                          0,
                        ),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: mobileWidth(context) / 2,
                          mainAxisSpacing: kElementGap,
                          crossAxisSpacing: kElementGap,
                        ),
                        itemCount: cities.length,
                        itemBuilder: (BuildContext context, index) {
                          final city = cities[index];
                          return CityCard(controller: controller, city: city);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
