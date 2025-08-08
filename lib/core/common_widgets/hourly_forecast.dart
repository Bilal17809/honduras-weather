import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/home/controller/home_controller.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '/core/constants/constant.dart';
import '/core/theme/theme.dart';
import 'shimmers.dart';

class HourlyForecastList extends StatelessWidget {
  final ScrollController? customScrollController;

  const HourlyForecastList({super.key, this.customScrollController});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final splashController = Get.find<SplashController>();
    final scrollController =
        customScrollController ?? homeController.scrollController;

    return Obx(() {
      final forecastDays =
          splashController.rawForecastData['forecast']?['forecastday'];
      final todayData = (forecastDays as List?)?.firstOrNull;
      final hourlyList = todayData?['hour'] as List? ?? [];
      final now = DateTime.now();
      final isLoading = forecastDays == null || homeController.isLoading.value;

      if (isLoading) {
        const shimmerItemCount = 24;
        return SizedBox(
          height: mobileHeight(context) * 0.14,
          child: ShimmerListView(
            itemCount: shimmerItemCount,
            itemWidth: mobileWidth(context) * 0.2,
            itemHeight: mobileHeight(context) * 0.12,
            itemMargin: (index) => EdgeInsets.only(
              left: index == 0 ? kBodyHp : 0,
              right: index == shimmerItemCount - 1 ? kBodyHp : kElementGap,
            ),
          ),
        );
      }

      return SizedBox(
        height: mobileHeight(context) * 0.14,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: hourlyList.length,
          itemBuilder: (context, index) {
            final hourData = hourlyList[index];
            final hourTime = DateTime.parse(hourData['time']);
            final hourLabel = TimeOfDay.fromDateTime(hourTime).format(context);
            final isCurrentHour = hourTime.hour == now.hour;

            return _HourlyForecast(
              day: hourLabel,
              isSelected: isCurrentHour,
              isFirst: index == 0,
              isLast: index == hourlyList.length - 1,
              hourData: hourData,
            );
          },
        ),
      );
    });
  }
}

class _HourlyForecast extends StatelessWidget {
  final String day;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final Map<String, dynamic>? hourData;

  const _HourlyForecast({
    required this.day,
    required this.isSelected,
    this.isFirst = false,
    this.isLast = false,
    this.hourData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: mobileWidth(context) * 0.17,
        margin: EdgeInsets.only(
          left: isFirst ? kBodyHp : 0,
          right: isLast ? kBodyHp : kElementGap,
        ),
        padding: const EdgeInsets.symmetric(vertical: kBodyHp),
        decoration: roundedSelectionDecoration(context, isSelected: isSelected),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  day,
                  style: bodyMediumStyle(context).copyWith(
                    color: isSelected ? null : secondaryText(context),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: kElementInnerGap),
              hourData?['condition']?['icon'] != null
                  ? Image.network(
                      'https:${hourData!['condition']['icon']}',
                      width: mediumIcon(context),
                      height: mediumIcon(context),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.wb_sunny,
                        size: primaryIcon(context),
                        color: kWhite,
                      ),
                    )
                  : Icon(
                      Icons.wb_sunny,
                      size: mediumIcon(context),
                      color: kWhite,
                    ),
              const SizedBox(height: kElementInnerGap),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  hourData != null ? '${hourData!['temp_c'].round()}°' : '0°',
                  style: bodyMediumStyle(context).copyWith(
                    color: isSelected ? null : secondaryText(context),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
