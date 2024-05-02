import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klasterify/app/theme/size.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var searchController = TextEditingController().obs;
  var focusNode = FocusNode().obs;
  final storage = GetStorage();

  var searchHistories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    print(maxHeight);
    getSearchHistories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSearchHistories() {
    try {
      final List<String> histories = storage.read('searchHistories') ?? [];
      searchHistories.value = histories;
    } catch (e) {
      searchHistories.value = [];
    }
  }
}
