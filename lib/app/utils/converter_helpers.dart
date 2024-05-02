import 'package:intl/intl.dart';

class ConvertFormatter {
  static String formatRupiah(num number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(number);
  }

  static String formatNumberCount(num number) {
    var formated = '';
    if (number >= 1000000000) {
      // Jika lebih dari atau sama dengan 1 miliar
      formated = '${(number / 1000000000).toStringAsFixed(1)}m';
    } else if (number >= 1000000) {
      // Jika lebih dari atau sama dengan 1 juta
      formated = '${(number / 1000000).toStringAsFixed(1)}jt';
    } else if (number >= 10000) {
      // Jika lebih dari atau sama dengan 10 ribu
      formated = '${(number / 1000).toStringAsFixed(1)}rb';
    } else {
      // Angka kurang dari 10 ribu
      formated = number.round().toString();
    }
    return formated.replaceAll(".0", "");
  }

  static String dateFormatter({
    required dynamic date,
    String format = "dd MMM yyyy, HH:mm",
  }) {
    // Ubah format tanggal menjadi objek DateTime
    DateTime dateTime = DateTime.parse(date);

    // Ubah format tanggal
    String formattedDate =
        DateFormat(format, 'id_ID').format(dateTime.toLocal());

    // Tampilkan tanggal yang sudah diubah formatnya
    return formattedDate;
  }
}
