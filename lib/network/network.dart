class BaseUrl {
  // static String domain = "http://10.0.2.2:8000/";
  // static String domain = "10.210.109.250";
  static String domain = "https://apimobilepersedikab.herokuapp.com";
  static String domainTrx = "https://apitransaksipersedikab.herokuapp.com";
  static String dash = "https://apidashpersedikab.herokuapp.com";
  // static String domainTrx = "http://10.0.2.2:1233";

  //auth
  static String register = domain + "/user/register";
  static String sendOtp = domain + "/user/otp";
  static String cekOtp = domain + "/user/cekOtp";
  static String login = domain + "/user/login";

  //berita
  static String berita = domain + "/berita";

  //team
  static String team = domain + "/klub/pemain";
  static String official = domain + "/klub/manajemen";
  static String statistik = domain + "/klub/statistic";
  static String saran = domain + "/klub/saran";

  //pertandingan
  static String pertandingan = domain + "/pertandingan/jadwal";
  static String history = domain + "/pertandingan/history";

  //komentar
  static String komentar = domain + "/berita/komentar/";
  static String kirimKomentar = domain + "/berita/komentar";
  static String laporKomentar = domain + "/berita/lapor/";

  //product
  static String tiket = domain + "/produk/tiket";
  static String merchandise = domain + "/produk/merchandise";

  static String transaksi = domainTrx + "/payment/bank/produk/";
  static String historyTransaksi = domainTrx + "/transaksi/mobile/produk/";
  static String cekTransaksiProduk = domainTrx + "/payment/status/produk/";

  static String transaksiTiket = domainTrx + "/payment/bank/tiket/";
  static String historyTiket = domainTrx + "/transaksi/mobile/tiket/";
  static String cekTransaksiTiket = domainTrx + "/payment/status/tiket/";

  static String struk = domainTrx + "/transaksi/tiket/";

  static String mytiket = domainTrx + "/tiket/";

  //dash
  static String getUserId = dash + "/user/";
  static String newOtp = dash + "/otp/";
  static String newKirimOtp = dash + "/cekotp";
}
