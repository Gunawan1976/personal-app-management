
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../shared/enum.dart';
import '../constant.dart';
import 'hex_color.dart';

class UtilsHelper {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


  static String getContentType(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case "txt":
        return "text/plain";
      case "jpg":
      case "jpeg":
        return "image/jpeg";
      case "png":
        return "image/png";
      case "pdf":
        return "application/pdf";
      case "xls":
        return "application/vnd.ms-excel";
      case "xlsx":
        return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
      default:
        return "application/octet-stream"; // Default content type
    }
  }

  static String binaryToString(String binary, {int group=8}) {
    RegExp exp = new RegExp(r"\d{"+"$group"+"}");
  Iterable<Match> matches = exp.allMatches(binary);
    Iterable<String?> list = matches.map((m) => m.group(0));

    return list.map((binaryChar) => int.parse(binaryChar!, radix: 2)) // Ubah biner ke integer
        .map((asciiCode) => String.fromCharCode(asciiCode)) // Ubah integer ke karakter
        .join(); // Gabungkan semua karakter jadi satu string
  }

  static String getConvertLevel(int level) {
    switch (level) {
      case 0:
        return "Pusat";
      case 1:
        return "Induk";
      case 2:
        return "Area";
      case 3:
        return "Unit";
      default:
        return "Pusat"; // Default content type
    }
  }

  static String getLevelRatingNegatif(DepthFlag depthFlag) {

    switch (depthFlag) {
      case DepthFlag.regional:
        return "uid";
      case DepthFlag.uid:
        return "up3";
      case DepthFlag.up3:
        return "ulp";
      default:
        return "ulp"; // Default content type
    }
  }

  static bool containsNumber(String input) {
    RegExp regExp = RegExp(r'\d'); // \d untuk mencari digit (angka)
    return regExp.hasMatch(input);
  }

  static String getLevelOutage(int level) {
    switch (level) {
      case 0:
        return "pusat";
      case 1:
        return "uid";
      case 2:
        return "up3";
      case 3:
        return "ulp";
      default:
        return "nasional"; // Default content type
    }
  }

  static String formatterCurrency(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String addDotEveryThreeDigits(String input) {
    input = input.replaceAll(RegExp(r'[^0-9]'), ''); // pastikan hanya angka
    StringBuffer result = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      result.write(input[i]);

      // Tambahkan titik setiap 3 digit, kecuali di akhir
      if ((i + 1) % 3 == 0 && i != input.length - 1) {
        result.write('.');
      }
    }

    return result.toString();
  }


  static String formatterCurrencyRupiah(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String timeStampfromEpoch(String time){
    int? timestamp = int.tryParse(time);
    // handle kalau bukan angk
    return timestamp == 0 ? "-": DateFormat("dd MMM yyyy, HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0, isUtc: true).toLocal());
  }

  static String replacePhoneNumber(String phoneNumber) {
    // Cek apakah nomor telepon dimulai dengan "08"
    if (phoneNumber.startsWith('08')) {
      // Ganti "08" dengan "62" untuk mengubah menjadi format internasional Indonesia
      return phoneNumber.replaceFirst('08', '62878');
    }
    return phoneNumber; // Jika tidak dimulai dengan "08", kembalikan nomor asli
  }

  static List<String> parseCookies(String? setCookieHeader) {
    // if (setCookieHeader == null) return [];
    // return setCookieHeader.split(', ');
    if (setCookieHeader == null || setCookieHeader.isEmpty) return [];
    return setCookieHeader.split(', ');
  }

  static String statusByNumber(int value){
    switch (value) {
      case 0:
        return "New";
      case 1:
        return "";
      case 2:
        return "Approve";
      default:
        return "";
    }
  }

  static Color colorByStatus(String value){
    switch (value) {
      case "New":
        return HexColor("#FF9500");
      case "Approve":
        return HexColor("#34C759");
      default:
        return HexColor("#139912");
    }
  }

  static String stringtoDatetime(String value){
    String formattedString = value.replaceFirstMapped(
        RegExp(r'(\+|-)\d{4}$'),
            (match) => "${match[0]!.substring(0, 3)}:${match[0]!.substring(3)}");

    return formattedString;
  }

  static String maskCharacter(String input, int n, {String mask = '*'}) {
    if (input.length <= n) return mask * input.length;
    String value = input.substring(0, n) + mask * (input.length - n);

    return value;
  }

  static double bytesToMB(int bytes) {
    return bytes / (1024 * 1024);
  }

  static Future<bool> isUsingCustomKeyboard() async {
    try {
      final bool result = await Constant.methodChannel.invokeMethod('isCustomKeyboard');
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> isUsingCustomKeyboardIos() async {
    try {
      final result = await MethodChannel('keyboard_check').invokeMethod<bool>('isCustomKeyboardIos');
      return result ?? false;
    } catch (e) {
      print("Gagal deteksi keyboard: $e");
      return false;
    }
  }


  static Future<bool> isValidSignature() async {
    try {
      return await Constant.signatureMethodChannel.invokeMethod('isSignatureValid');
    } catch (_) {
      return false;
    }
  }

  static String formatLabelMultiline(String key,String replaceValue) {
    String cleaned = key
        .replaceAll(replaceValue, '')
        .replaceAll('_', ' ')
        .trim();

    // Ubah jadi Title Case (tiap kata huruf kapital)
    cleaned = cleaned.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    // Jika pendek, kembalikan langsung
    if (cleaned.length <= 8) return cleaned;

    // Cari spasi terdekat setelah karakter ke-10
    int splitIndex = cleaned.indexOf(' ', 8);

    if (splitIndex != -1) {
      // Sisipkan newline di sana
      cleaned = cleaned.replaceRange(splitIndex, splitIndex + 1, '\n');
    }
    // else {
    //   // Kalau tidak ada spasi, paksa potong
    //   // cleaned = cleaned.substring(0, 10) + '\n' + cleaned.substring(10);
    // }

    return cleaned;
  }

  static String translateMessage(String key) {
    const messages = {
      'unauthorized': 'Sesi login anda telah berakhir. Silahkan login kembali',
      'CAPTCHA is invalid.': 'Mohon periksa kembali kode Captcha yang anda masukan.',
      'user_inactive': 'Akun anda masih dalam peninjauan. Anda perlu mendapat persetujuan sebelum dapat mulai menggunakan sistem',
      'user_not_found': 'Mohon periksa kembali username / password anda',
      'authorization code already consumed': 'Kode verifikasi telah kadaluarsa',
      'input_user_name': 'Masukkan nama user terlebih dahulu',
      'user_name_min_3': 'Nama user minimal 3 karakter',
      'select_upi_first': 'Pilih Nama UPI terlebih dahulu',
      'password_mismatch': 'Mohon periksa kembali Username/Password anda.',
      'Nama permission sudah dipakai': 'Nama PERMISSION sudah dipakai, mohon ganti dengan nama yang lain.',
      'record_not_found': 'Maaf informasi dari data yang anda cari saat ini tidak tersedia didalam sistem.',
      'CTT Request Detail not found': 'Maaf informasi dari data yang anda cari saat ini tidak tersedia didalam sistem.',
      'record not found': 'Maaf informasi dari data yang anda cari saat ini tidak tersedia didalam sistem.',
      'Title sudah dipakai': 'Maaf judul (TITLE) yang anda tuliskan sudah terdaftar didalam Database, mohon ganti dengan yang lain.',
      'password_expired': 'password_expired',
      'password_exist': 'Anda sudah pernah menggunakan password ini sebelumnya, Mohon ganti password Anda.',
      'forbidden': 'Maaf anda tidak memiliki akses untuk melakukan Aksi ini, harap hubungi Administrator.',
      'limit_exceed': 'Anda melakukan terlalu banyak request. Mohon tunggu 30 detik.',
      'ip_not_valid': 'IP anda tidak Valid. Mohon melakukan Login ulang.',
      'ip_blocked': 'IP diblokir oleh Sistem. Mohon hubungi Administrator.',
      'browser_not_valid': 'Browser anda tidak Valid. Mohon melakukan Login ulang.',
      'validation_errors': 'Terjadi Kesalahan. Mohon periksa kembali inputan Anda!',
      'user_blocked': 'Akun diblokir oleh Sistem. Mohon hubungi Administrator.',
      'country_blocked': 'Anda mengakses dari Negara yang Tidak Diperbolehkan oleh Sistem. Mohon hubungi Administrator atau cek Koneksi VPN anda.',
      'already_requested': 'Anda telah melakukan Request sebelumnya, silahkan Cek Email anda.',
      'daily_quota_reach': 'Anda sudah mencapai kuota harian. Mohon menunggu hingga kuota harian direset pada hari berikutnya.',
      'No Agenda belum terbentuk, silahkan Create CTT terlebih dahulu': 'No Agenda belum terbentuk, silahkan Create CTT terlebih dahulu!',
      '':'Terjadi kesalahan pada server, silahkan coba lagi.',
    };

    return messages[key] ?? key;
  }


}
