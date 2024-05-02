import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/asset.dart';
import '../../../modules/result/views/result_view.dart';
import '../../../theme/colors.dart';
import '../../../theme/size.dart';
import '../../../theme/textstyles.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get.find<HomeController>();
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Klasterify',
          style: interBold.copyWith(fontSize: maxHeight / 45),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(marginLarge),
        children: [
          SizedBox(
            height: maxHeight > 700 ? maxHeight / 4 : maxHeight / 3.7,
            width: maxWidth,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: maxHeight > 700 ? maxHeight / 4 : maxHeight / 3.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLarge),
                      image: const DecorationImage(
                          image: AssetImage(Asset.imgJumbotron),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: maxHeight > 700 ? maxHeight / 4 : maxHeight / 3.7,
                    width: maxWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.9),
                            primaryColor.withOpacity(0.7),
                            primaryColor.withOpacity(0.25),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(radiusLarge),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: marginLarge, horizontal: marginLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Temukan dan Pilih',
                          style: interBold.copyWith(
                              fontSize: maxHeight / 47, color: whiteColor),
                        ),
                        SizedBox(
                          height: marginSmall,
                        ),
                        Text(
                          'Buat perjalanan pencarian produk Anda jadi semakin mudah',
                          style: interMedium.copyWith(
                              fontSize: maxHeight / 58, color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: marginLarge),
          _buildSearchBar(),
          SizedBox(height: marginLarge),
          _buildButtonSearch(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Obx(
      () => Form(
        key: controller.formKey,
        child: TextFormField(
          controller: controller.searchController.value,
          focusNode: controller.focusNode.value,
          autofillHints: controller.searchHistories,
          textInputAction: TextInputAction.search,
          style:
              interMedium.copyWith(fontSize: maxHeight / 56, color: blackColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            contentPadding: EdgeInsets.symmetric(
                vertical: marginMedium, horizontal: marginSmall),
            hintText: 'Cari nama produk atau kategori',
            hintStyle: interMedium.copyWith(
              fontSize: maxHeight / 56,
              color: greyColor,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber, width: 2),
              borderRadius: BorderRadius.circular(radiusMedium),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(radiusMedium),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
            ),
          ),
          onFieldSubmitted: (value) {
            if (controller.searchController.value.text.isNotEmpty &&
                controller.formKey.currentState!.validate()) {
              Get.to(
                () => const ResultView(),
                arguments: {'keyword': controller.searchController.value.text},
              );
              controller.focusNode.value.unfocus();
              controller.searchController.value.clear();
            }
          },
        ),
      ),
    );
  }

  Widget _buildButtonSearch() {
    return CustomRoundedButton(
        text: 'Cari Produk',
        action: () {
          if (controller.searchController.value.text.isNotEmpty &&
              controller.formKey.currentState!.validate()) {
            Get.to(
              () => const ResultView(),
              arguments: {'keyword': controller.searchController.value.text},
            );
            controller.focusNode.value.unfocus();
            controller.searchController.value.clear();
          }
        },
        height: maxHeight > 700 ? maxHeight / 15 : maxHeight / 13,
        color: primaryColor,
        isShadow: true,
        textColor: whiteColor,
        fontSize: maxHeight / 52);
  }
}
