class BaseUrl {
  static String domain = "http://10.0.2.2:8000/";

  //auth
  static String register = domain + "user/register";
  static String sendOtp = domain + "user/otp";
  static String cekOtp = domain + "user/cekOtp";
  static String login = domain + "user/login";

  //berita
  static String berita = domain + "berita";

  //team
  static String team = domain + "klub/pemain";
  static String official = domain + "klub/manajemen";
  static String statistik = domain + "klub/statistic";
  static String saran = domain + "klub/saran";

  //pertandingan
  static String pertandingan = domain + "pertandingan/jadwal";
  static String history = domain + "pertandingan/history";

  //komentar
  static String komentar = domain + "berita/komentar/";
  static String kirimKomentar = domain + "berita/komentar";
}
