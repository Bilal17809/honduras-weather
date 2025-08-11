import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animation/view/animated_weather_icon.dart';
import '/ad_manager/ad_manager.dart';
import '/presentation/splash/controller/splash_controller.dart';
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
    final ad = Get.find<InterstitialAdManager>();
    return Scaffold(
      backgroundColor: kWhite,
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/splash.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(kBodyHp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: kElementInnerGap),
                      Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'HONDURAS',
                              style: headlineLargeStyle(
                                context,
                              ).copyWith(color: kYellow, fontSize: 72),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AnimatedDefaultTextStyle(
                              style: headlineLargeStyle(context).copyWith(
                                color: controller.title.value,
                                fontSize: 80,
                              ),
                              duration: const Duration(milliseconds: 1500),
                              child: Text.rich(TextSpan(text: 'Weather')),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              // First line
                              ...List.generate(
                                'Check live weather for major cities'.length,
                                (index) {
                                  final isVisible =
                                      index < controller.visibleLetters.value;
                                  return TextSpan(
                                    text:
                                        'Check live weather for major cities'[index],
                                    style: titleSmallStyle(context).copyWith(
                                      color: isVisible ? kBlack : transparent,
                                    ),
                                  );
                                },
                              ),
                              const TextSpan(text: '\n'),
                              ...List.generate(
                                'and remote areas in Honduras.'.length,
                                (index) {
                                  final isVisible =
                                      index < controller.visibleLetters.value;
                                  return TextSpan(
                                    text:
                                        'and remote areas in Honduras.'[index],
                                    style: titleSmallStyle(context).copyWith(
                                      color: isVisible ? kBlack : transparent,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedWeatherIcon(
                        imagePath: 'images/splash-icon.png',
                        condition: 'thunderstorm',
                        width: mobileHeight(context) * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: mobileHeight(context) * 0.1,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: controller.showButton.value
                              ? AnimatedOpacity(
                                  opacity: controller.showButton.value
                                      ? 1.0
                                      : 0.0,
                                  duration: const Duration(milliseconds: 600),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kBodyHp,
                                    ),
                                    child: CustomButton(
                                      width: mobileWidth(context) * 0.35,
                                      height: 52,
                                      backgroundColor: kWhite.withValues(
                                        alpha: 0.2,
                                      ),
                                      shadowColor: kBlue,
                                      textColor: textWhiteColor,
                                      onPressed: () async {
                                        if (!ad.isShow.value) {
                                          ad.showAd();
                                          Get.off(() => HomeView());
                                        } else {
                                          Get.off(() => HomeView());
                                        }
                                      },
                                      text: "Let's Go",
                                    ),
                                  ),
                                )
                              : LoadingAnimationWidget.dotsTriangle(
                                  color: kBlue,
                                  size: mobileWidth(context) * 0.1,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Opacity(opacity: 0.4, child: Image.asset('images/lightning.png')),
          ],
        ),
      ),
    );
  }
}
