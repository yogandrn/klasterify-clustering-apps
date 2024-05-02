import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:klasterify/app/config/api.dart';
import 'package:klasterify/app/utils/validation_helpers.dart';
import 'package:klasterify/app/widgets/custom_dialog.dart';

import '../../../data/models/product.dart';

class ResultController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var keyword = ''.obs;
  var tabsLabels = <String>['Cluster 1', 'Cluster 2', 'Cluster 3'].obs;
  var allProducts = <Product>[].obs;
  var cluster1 = <Product>[].obs;
  var cluster2 = <Product>[].obs;
  var cluster3 = <Product>[].obs;
  var relatedCluster1 = <Product>[].obs;
  var relatedCluster2 = <Product>[].obs;
  var relatedCluster3 = <Product>[].obs;
  var productsIds = [].obs;
  List<String> dropdownItems = ['Relevan', 'Terlaris', 'Termurah', 'Termahal'];
  var selectedSortBy = 'RELEVAN'.obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    keyword.value = arguments['keyword'];
    fetchDataResult();
  }

  @override
  void onClose() {
    keyword.close();
    allProducts.clear();
    cluster1.clear();
    cluster2.clear();
    cluster3.clear();
    productsIds.clear();
    super.onClose();
  }

  Future<void> fetchDataResult() async {
    try {
      print('fetch data...');
      isLoading.value = true;
      isError.value = false;
      final connection = await ValidationHelpers.checkConnection();
      if (connection != ConnectivityResult.none) {
        final encodedKeyword = Uri.encodeComponent(keyword.value);
        final url = Uri.parse(API.clusteringProduct + encodedKeyword);
        final headers = {
          'Accept': 'application/json',
        };

        final response = await http.get(url, headers: headers);
        final responseBody = jsonDecode(response.body);

        switch (response.statusCode) {
          case 200:
            List<Product> tempData = [];
            List<Product> tempCluster1 = [];
            List<Product> tempCluster2 = [];
            List<Product> tempCluster3 = [];
            List listData = responseBody['data'];
            for (var item in listData) {
              var data = Product.fromJson(item);

              // tambahkan data sesuai cluster
              switch (data.cluster) {
                case 1:
                  tempCluster1.add(data);
                  break;
                case 2:
                  tempCluster2.add(data);
                  break;
                case 3:
                  tempCluster3.add(data);
                  break;
                default:
              }
              // tambahkan data ke dalam tempData
              tempData.add(data);
            }

            // ubah value data pada controller
            allProducts.value = tempData;
            relatedCluster1.value = tempCluster1;
            relatedCluster2.value = tempCluster2;
            relatedCluster3.value = tempCluster3;
            cluster1.value = tempCluster1;
            cluster2.value = tempCluster2;
            cluster3.value = tempCluster3;
            break;

          default:
            isError.value = true;
            showCustomSnackbar(
              message: 'Terjadi kesalahan saat memproses data',
              isError: true,
            );
        }
      } else {
        isError.value = true;
        showErrorConnection();
      }
    } catch (e) {
      isError.value = true;
      showCustomSnackbar(
        message: 'Terjadi kesalahan saat memproses data',
        isError: true,
      );
      throw Exception('Error on Clustering : $e');
    } finally {
      isLoading.value = false;
    }
  }

  updateSortByCluster({required String sortBy}) {
    try {
      isLoading.value = true;
      print(sortBy.toUpperCase());
      selectedSortBy.value = sortBy.toUpperCase();
      switch (sortBy.toUpperCase()) {
        case 'RELEVAN':
          cluster1.clear();
          cluster2.clear();
          cluster3.clear();
          for (var item in allProducts.toList()) {
            if (item.cluster == 1) {
              cluster1.add(item);
            }
            if (item.cluster == 2) {
              cluster2.add(item);
            }
            if (item.cluster == 3) {
              cluster3.add(item);
            }
          }
          break;
        case 'TERLARIS':
          cluster1.sort((a, b) => b.sold.compareTo(a.sold));
          cluster2.sort((a, b) => b.sold.compareTo(a.sold));
          cluster3.sort((a, b) => b.sold.compareTo(a.sold));
          break;
        case 'TERMAHAL':
          cluster1.sort((a, b) => b.price.compareTo(a.price));
          cluster2.sort((a, b) => b.price.compareTo(a.price));
          cluster3.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'TERMURAH':
          cluster1.sort((a, b) => a.price.compareTo(b.price));
          cluster2.sort((a, b) => a.price.compareTo(b.price));
          cluster3.sort((a, b) => a.price.compareTo(b.price));
          break;
        default:
          cluster1.value = relatedCluster1.toList();
          cluster2.value = relatedCluster2.toList();
          cluster3.value = relatedCluster3.toList();
      }
    } catch (e) {
      cluster1.value = relatedCluster1.toList();
      cluster2.value = relatedCluster2.toList();
      cluster3.value = relatedCluster3.toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> onWillPop() async {
    print(currentIndex.value);
    if (currentIndex.value == 0) {
      return true;
    } else {
      currentIndex.value = 0;
    }
    return false;
  }
}
