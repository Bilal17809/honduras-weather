import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/presentation/splash/controller/splash_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/presentation/home/view/home_view.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constant.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    return Obx(
      () => Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: mobileHeight(context) * 0.1),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: controller.showButton.value
                  ? AnimatedOpacity(
                      opacity: controller.showButton.value ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 600),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kBodyHp,
                        ),
                        child: CustomButton(
                          width: mobileWidth(context) * 0.4,
                          height: 50,
                          backgroundColor: kOrange,
                          shadowColor: kDarkOrange,
                          textColor: kBlack,
                          onPressed: () async {
                            Get.to(() => HomeView());
                          },
                          text: "Let's Go",
                        ),
                      ),
                    )
                  : LoadingAnimationWidget.newtonCradle(
                      color: kOrange,
                      size: mobileWidth(context) * 0.2,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
