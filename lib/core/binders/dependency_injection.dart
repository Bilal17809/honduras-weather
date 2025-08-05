import 'package:get/get.dart';
import 'package:honduras_weather/presentation/cities/controller/cities_controller.dart';
import '/presentation/daily_forecast/controller/daily_forecast_controller.dart';
import '/presentation/home/controller/home_controller.dart';
import '/presentation/splash/controller/splash_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CitiesController>(() => CitiesController(), fenix: true);
    Get.lazyPut<DailyForecastController>(
      () => DailyForecastController(),
      fenix: true,
    );
  }
}
