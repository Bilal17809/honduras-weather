import 'package:get/get.dart';
import '/data/models/city_model.dart';
import '/core/services/services.dart';
import '/presentation/splash/controller/splash_controller.dart';

class HomeController extends GetxController {
  final CityStorageService cityStorageService;
  HomeController() : cityStorageService = Get.find<CityStorageService>();
  final splashController = Get.find<SplashController>();
  final conditionService = Get.find<ConditionService>();
  var isDrawerOpen = false.obs;
  final selectedCities = <CityModel>[].obs;
  final selectedCity = Rx<CityModel?>(null);

  @override
  onInit() async {
    super.onInit();
    while (!splashController.isAppReady) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    final allCities = splashController.allCities;
    final fallbackCity = splashController.currentCity;
    final selectedCityFromStorage = await cityStorageService.loadSelectedCity(
      allCities: allCities,
      currentLocationCity: fallbackCity,
    );
    selectedCities.value = [selectedCityFromStorage];
    await _initializeSelectedCity(selectedCityFromStorage);
    ever(splashController.selectedCity, (CityModel? newCity) async {
      if (newCity != null &&
          LocationUtilsService.fromCityModel(selectedCity.value!) !=
              LocationUtilsService.fromCityModel(newCity)) {
        selectedCities.value = [newCity];
        await _initializeSelectedCity(newCity);
      }
    });
  }

  Future<void> _initializeSelectedCity(CityModel city) async {
    while (!splashController.isAppReady) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    selectedCity.value = city;
  }

  List<CityModel> get allCities => splashController.allCities;
  CityModel? get currentLocationCity => splashController.currentCity;
  String get selectedCityName =>
      selectedCity.value?.city ?? splashController.selectedCityName;
  bool get isAppReady => splashController.isAppReady;
}
