import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/core/constants/constant.dart';
import '../controller/cities_controller.dart';
import 'widgets/city_card.dart';
import 'widgets/current_location_card.dart';

class CitiesView extends StatelessWidget {
  const CitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final CitiesController controller = Get.find();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
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
                      // onSearch: (value) => controller.searchCities(value),
                      onSearch: (value) {},
                      backgroundColor: dark
                          ? kWhite.withValues(alpha: 0.3)
                          : getPrimaryColor(context),
                      borderColor: controller.hasSearchError.value
                          ? kRed
                          : getSecondaryColor(context),
                      iconColor: controller.hasSearchError.value
                          ? kRed
                          : getSecondaryColor(context),
                      textColor: primaryText(context),
                    );
                  }),
                ),
                // Obx(
                //   () => controller.hasSearchError.value
                //       ? Padding(
                //           padding: const EdgeInsets.fromLTRB(
                //             kBodyHp,
                //             kElementInnerGap,
                //             kBodyHp,
                //             0,
                //           ),
                //           child: Row(
                //             children: [
                //               Icon(
                //                 Icons.error_outline,
                //                 color: kRed,
                //                 size: smallIcon(context),
                //               ),
                //               const SizedBox(width: kElementWidthGap),
                //               Expanded(
                //                 child: Text(
                //                   controller.searchErrorMessage.value,
                //                   style: bodySmallStyle(context).copyWith(
                //                     color: kRed,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         )
                //       : const SizedBox.shrink(),
                // ),
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth / 2;
                      final height = 150;

                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          kBodyHp,
                          0,
                          kBodyHp,
                          0,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kElementGap,
                          crossAxisSpacing: kElementGap,
                          childAspectRatio: width / height,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          final city = 'Lahore';
                          return CityCard(controller: controller);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
