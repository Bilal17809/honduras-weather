import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/core/common_widgets/common_widgets.dart';
import 'package:honduras_weather/core/global_keys/global_key.dart';
import 'package:honduras_weather/presentation/home/controller/home_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '/core/services/date_time_service.dart';
import '/core/theme/theme.dart';
import '/core/constants/constant.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) async {
        if (didPop) return;
        final shouldExit = await _showExitDialog(context);
        if (shouldExit == true) SystemNavigator.pop();
      },
      child: Scaffold(
        key: globalKey,
        drawer: const AppDrawer(),
        onDrawerChanged: (isOpen) {
          homeController.isDrawerOpen.value = isOpen;
        },
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
                TitleBar(
                  subtitle: '',
                  useBackButton: false,
                  actions: [
                    IconActionButton(
                      onTap: () {},
                      icon: Icons.add,
                      color: getIconColor(context),
                      size: secondaryIcon(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kBodyHp * 2,
                    right: kBodyHp * 2,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'London\nUnited Kingdom',
                                style: headlineSmallStyle(context),
                              ),
                              Text(
                                DateTimeService.getFormattedCurrentDate(),
                                style: bodyLargeStyle(context),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: primaryIcon(context),
                            child: Image.asset(
                              'images/map.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/weather_icon.png',
                                  width: primaryIcon(context),
                                ),
                                const SizedBox(height: kElementInnerGap),
                                Text(
                                  'Thunderstorm',
                                  style: bodyBoldMediumStyle(context),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('27°', style: headlineLargeStyle(context)),
                                const SizedBox(height: kElementInnerGap),
                                Text(
                                  'Feels like 32°',
                                  style: bodyMediumStyle(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await PanaraConfirmDialog.show(
      context,
      title: 'Exit App',
      message: 'Do you really want to exit the app?',
      confirmButtonText: 'Exit',
      cancelButtonText: 'Cancel',
      onTapConfirm: () => Navigator.pop(context, true),
      onTapCancel: () => Navigator.pop(context, false),
      panaraDialogType: PanaraDialogType.custom,
      color: getSecondaryColor(context),
      barrierDismissible: false,
    );
  }
}
