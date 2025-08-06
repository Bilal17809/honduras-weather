import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/mixins/connectivity_mixin.dart';
import '/core/services/services.dart';
import '/data/models/city_model.dart';
import '/presentation/splash/controller/splash_controller.dart';

class CitiesController extends GetxController with ConnectivityMixin {
  final splashController = Get.find<SplashController>();
  final conditionService = Get.find<ConditionService>();
  var hasSearchError = false.obs;
  var searchErrorMessage = ''.obs;
  var isSearching = false.obs;

  var filteredCities = <CityModel>[].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _syncSplash();
  }

  Future<void> _syncSplash() async {
    while (!splashController.isAppReady) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    filteredCities.value = splashController.allCities;
    searchController.addListener(() {
      searchCities(searchController.text);
    });
  }

  void searchCities(String query) {
    if (query.isEmpty) {
      filteredCities.value = splashController.allCities;
      hasSearchError.value = false;
      return;
    }
    isSearching.value = true;
    hasSearchError.value = false;
    try {
      final results = splashController.allCities
          .where(
            (city) =>
                city.city.toLowerCase().contains(query.toLowerCase()) ||
                city.cityAscii.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      if (results.isEmpty) {
        hasSearchError.value = true;
        searchErrorMessage.value = 'No cities found matching "$query"';
        filteredCities.clear();
      } else {
        filteredCities.value = results;
        hasSearchError.value = false;
      }
    } catch (e) {
      hasSearchError.value = true;
      searchErrorMessage.value = 'Search failed. Please try again.';
      filteredCities.clear();
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> selectCity(CityModel city) async {
    await initWithConnectivityCheck(
      context: Get.context!,
      onConnected: () async {
        splashController.selectedCity.value = city;
        await splashController.cityStorageService.saveSelectedCity(city);
      },
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
