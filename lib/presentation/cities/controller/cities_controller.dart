import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CitiesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var hasSearchError = false.obs;
  var searchErrorMessage = ''.obs;
  var isSearching = false.obs;
}
