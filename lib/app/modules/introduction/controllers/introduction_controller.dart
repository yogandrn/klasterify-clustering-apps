import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:klasterify/app/modules/home/views/home_view.dart';

class IntroductionController extends GetxController {
  var listContentConfig = <ContentConfig>[].obs;
  final storage = GetStorage();

  var isInternetConnected = false.obs;

  late Function goToTab;

  // START On Boarding Content
  String title1 = 'Selamat datang di Klasterify';
  String title2 = 'Eksplorasi produk dengan mudah';
  String title3 = 'Temukan rekomendasi produk dengan cluster unggulan';

  String image1 =
      'https://klasterify.andrianation.my.id/assets/onboarding-1.png';
  String image2 =
      'https://klasterify.andrianation.my.id/assets/onboarding-2.png';
  String image3 =
      'https://klasterify.andrianation.my.id/assets/onboarding-3.png';

  String desc1 =
      'Jelajahi produk berkualitas tinggi, dan temukan kemudahan dalam menemukan barang yang sesuai dengan preferensi Anda.';
  String desc2 =
      'Temukan produk dengan mudah, sesuaikan preferensi Anda, dan nikmati penggunaan aplikasi yang intuitif untuk perjalanan belanja yang lebih menyenangkan.';
  String desc3 =
      'Lihat produk paling unggul berdasarkan skor rating, jumlah terjual, dan jumlah ulasan pelanggan. Pengalaman belanja yang lebih pintar dan terfokus dimulai di sini.';

  // END On Boarding Content

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  void onDonePress() {
    storage.write('isIntroductionRead', true);
    Get.offAll(() => const HomeView());
  }

  void onTabChangeCompleted(index) {
    print("onTabChangeCompleted, index: $index");
  }
}
