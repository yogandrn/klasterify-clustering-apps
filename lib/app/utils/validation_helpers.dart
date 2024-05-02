import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ValidationHelpers {
  static String? validateKeyword(String value) {
    if (value.isEmpty || value == ' ') {
      return 'Nama tidak boleh kosong';
    } else if (value.length < 4 || value.trim().length < 4) {
      return 'Minimal 4 karakter';
    } else if (RegExp(r'[0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\-]').hasMatch(value)) {
      return 'Nama tidak boleh mengandung angka dan simbol!';
    } else {
      return null;
    }
  }

  static Future<ConnectivityResult> checkConnection() async {
    print('check connection...');
    return await (Connectivity().checkConnectivity());
  }
}
