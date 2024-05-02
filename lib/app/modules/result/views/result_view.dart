import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../config/asset.dart';
import '../../../data/models/product.dart';
import '../../../theme/colors.dart';
import '../../../theme/size.dart';
import '../../../theme/textstyles.dart';
import '../../../widgets/custom_item_product_grid.dart';
import '../../../widgets/custom_view_empty.dart';
import '../../../widgets/custom_view_error.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ResultController());
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: _buildAppBar(),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.stretchedDots(
                        color: primaryColor, size: maxHeight / 20),
                    Text(
                      'Mohon tunggu...',
                      style: interMedium.copyWith(fontSize: maxHeight / 60),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return controller.isError.value
              ? Scaffold(
                  appBar: _buildAppBar(),
                  body: SafeArea(
                    child: Center(
                      child: CustomErrorView(
                        onRefresh: controller.fetchDataResult,
                      ),
                    ),
                  ),
                )
              : controller.allProducts.isEmpty
                  ? Scaffold(
                      appBar: _buildAppBar(),
                      body: SafeArea(
                          child: Center(
                        child: CustomEmptyView(
                          title: 'Tidak Ditemukan',
                          message:
                              'Hasil pencarian tidak ditemukan. Cobalah kata kunci yang lain.',
                          assetPath: Asset.imgSearchNotFound,
                        ),
                      )),
                    )
                  : DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        backgroundColor: backgroundColor,
                        appBar: _buildAppBar(),
                        body: SafeArea(
                          child: Column(
                            children: [
                              _buildTabBar(),
                              Expanded(child: _buildTabBarView()),
                            ],
                          ),
                        ),
                        floatingActionButton: Padding(
                          padding: EdgeInsets.only(bottom: marginLarge),
                          child: FloatingActionButton(
                            child: const Icon(
                              Icons.sort_rounded,
                              color: whiteColor,
                            ),
                            onPressed: () => showBottomSheetSorting(),
                          ),
                        ),
                      ),
                    );
        }
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Hasil Clustering',
        style: interBold.copyWith(fontSize: maxHeight / 45),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: maxHeight / 15,
      color: primaryColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          // onTap: (value) {
          //   print(controller.currentIndex.value);
          //   controller.currentIndex.value = value;
          //   print(controller.currentIndex.value);
          // },
          tabAlignment: TabAlignment.center,
          labelColor: whiteColor,
          labelPadding: EdgeInsets.symmetric(
              horizontal: maxWidth / 20, vertical: maxHeight / 72),
          labelStyle: interBold.copyWith(
            fontSize: maxHeight / 55,
          ),
          unselectedLabelStyle: interMedium.copyWith(
            fontSize: maxHeight / 57,
          ),
          unselectedLabelColor: whiteColor.withOpacity(0.6),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: backgroundColor,
          // tabs: controller.tabsLabels
          //     .map((element) => Tab(text: element))
          //     .toList(),
          tabs: [
            Tab(text: 'Produk Unggulan (${controller.cluster3.length})'),
            Tab(text: 'Produk Menengah (${controller.cluster2.length})'),
            // Container(
            //   width: maxWidth / 3.05,
            //   child: Tab(text: 'Cluster 3'),
            // ),
            Tab(text: 'Kurang Populer (${controller.cluster1.length})'),
          ],
        ),
      ),
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(children: [
      _buildTabBody(products: controller.cluster3.toList(), cluster: 3),
      _buildTabBody(products: controller.cluster2.toList(), cluster: 2),
      _buildTabBody(products: controller.cluster1.toList(), cluster: 1),
      // _buildClusterChart()
      // CustomPieChart(
      //     cluster1: controller.cluster1.length,
      //     cluster2: controller.cluster2.length,
      //     cluster3: controller.cluster3.length),
    ]);
  }

  Widget _buildTabBody({required List<Product> products, int cluster = 1}) {
    return products.isEmpty
        ? Center(
            child: CustomEmptyView(
              message: 'Tidak ada produk pada cluster ini',
            ),
          )
        : GridView.builder(
            padding: EdgeInsets.symmetric(
                vertical: maxHeight / 60, horizontal: maxWidth / 80),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2,
              mainAxisSpacing: maxHeight / 100,
              crossAxisSpacing: maxHeight / 100,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ItemProductGridCard(
                product: products[index],
              );
            },
          );
  }

  showBottomSheetSorting() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(
            vertical: marginLarge, horizontal: marginLarge),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        height: maxHeight > 700 ? maxHeight / 3.4 : maxHeight / 2.8,
        child: Column(
          children: [
            Text(
              'Urutkan Berdasarkan',
              style: interSemiBold.copyWith(
                fontSize: maxHeight / 56,
                height: 2,
              ),
            ),
            Column(
              children: controller.dropdownItems
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        Get.back();
                        controller.selectedSortBy.value = item.toUpperCase();
                        controller.updateSortByCluster(
                          sortBy: item.toUpperCase(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              controller.selectedSortBy.value ==
                                      item.toUpperCase()
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_off_rounded,
                              color: primaryColor,
                              size: maxHeight / 30,
                            ),
                            SizedBox(
                              width: marginMedium,
                            ),
                            Text(
                              item,
                              style: interMedium.copyWith(
                                  fontSize: maxHeight / 56),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
