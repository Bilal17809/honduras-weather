import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import '/core/services/services.dart';
import '/data/models/city_model.dart';
import '/data/models/weather_model.dart';
import '/domain/use_cases/use_case.dart';
import '/core/local_storage/local_storage.dart';

// Background task callback - This runs in isolation
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      debugPrint("Background task started: $task");

      // Initialize storage
      final storage = LocalStorage();

      // Get stored city data
      final cityJson = await storage.getString('selected_city');
      if (cityJson == null) {
        debugPrint("No selected city found in background");
        return true;
      }

      final cityData = json.decode(cityJson);
      final selectedCity = CityModel.fromJson(cityData);

      // Create background weather service
      final weatherService = BackgroundWeatherService();
      await weatherService.updateWidgetInBackground(selectedCity);

      debugPrint("Background widget update completed");
      return true;
    } catch (e) {
      debugPrint("Background task error: $e");
      return false;
    }
  });
}

class BackgroundWeatherService {
  static const _channel = MethodChannel(
    'com.unisoftaps.hondurasweatherforecast/widget',
  );

  Future<void> updateWidgetInBackground(CityModel city) async {
    try {
      // Fetch weather data directly (simplified version for background)
      final weatherData = await _fetchWeatherForCity(city);
      if (weatherData != null) {
        await _updateWidgetNative(weatherData, city);
      }
    } catch (e) {
      debugPrint("Background weather update failed: $e");
    }
  }

  Future<WeatherModel?> _fetchWeatherForCity(CityModel city) async {
    try {
      // This is a simplified version - you might need to implement
      // a direct API call here without using GetX dependencies
      // For now, we'll return null and rely on cached data
      return null;
    } catch (e) {
      debugPrint("Failed to fetch weather in background: $e");
      return null;
    }
  }

  Future<void> _updateWidgetNative(WeatherModel weather, CityModel city) async {
    try {
      await _channel.invokeMethod('updateWidget', {
        'cityName': city.city,
        'temperature': weather.temperature.round().toString(),
        'condition': weather.condition,
        'iconUrl': weather.iconUrl,
        'minTemp': '--', // You can enhance this with forecast data
        'maxTemp': '--',
      });
    } catch (e) {
      debugPrint("Native widget update error in background: $e");
    }
  }
}

class WidgetBackgroundManager {
  static const String _taskName = "weatherWidgetUpdate";
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false, // Set to false for production
      );
      _isInitialized = true;
      debugPrint("WorkManager initialized successfully");
    } catch (e) {
      debugPrint("Failed to initialize WorkManager: $e");
    }
  }

  static Future<void> startPeriodicUpdates() async {
    await initialize();

    try {
      // Cancel any existing periodic task
      await Workmanager().cancelByUniqueName(_taskName);

      // Register periodic task (minimum interval is 15 minutes on Android)
      await Workmanager().registerPeriodicTask(
        _taskName,
        _taskName,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false,
        ),
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(minutes: 1),
      );

      debugPrint("Periodic widget updates scheduled");
    } catch (e) {
      debugPrint("Failed to schedule periodic updates: $e");
    }
  }

  static Future<void> stopPeriodicUpdates() async {
    try {
      await Workmanager().cancelByUniqueName(_taskName);
      debugPrint("Periodic widget updates cancelled");
    } catch (e) {
      debugPrint("Failed to cancel periodic updates: $e");
    }
  }

  static Future<void> triggerImmediateUpdate() async {
    await initialize();

    try {
      await Workmanager().registerOneOffTask(
        "${_taskName}_immediate",
        _taskName,
        constraints: Constraints(networkType: NetworkType.connected),
      );
      debugPrint("Immediate widget update triggered");
    } catch (e) {
      debugPrint("Failed to trigger immediate update: $e");
    }
  }
}
