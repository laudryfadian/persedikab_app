class Merchandise {
  late bool status;
  late int statusCode;
  late String timestamp;
  late String message;
  late Result result;

  Merchandise(
      {required this.status,
      required this.statusCode,
      required this.timestamp,
      required this.message,
      required this.result});

  Merchandise.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    message = json['message'];
    result =
        (json['result'] != null ? new Result.fromJson(json['result']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  late List<Data> data;

  Result({required this.data});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String sId;
  late String kodeProduk;
  late String nama;
  late List<String> gambar;
  late int harga;
  late String ukuran;
  late String kategori;
  late int stok;
  late int iV;

  Data(
      {required this.sId,
      required this.kodeProduk,
      required this.nama,
      required this.gambar,
      required this.harga,
      required this.ukuran,
      required this.kategori,
      required this.stok,
      required this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    kodeProduk = json['kodeProduk'];
    nama = json['nama'];
    gambar = json['gambar'].cast<String>();
    harga = json['harga'];
    ukuran = json['ukuran'];
    kategori = json['kategori'];
    stok = json['stok'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['kodeProduk'] = this.kodeProduk;
    data['nama'] = this.nama;
    data['gambar'] = this.gambar;
    data['harga'] = this.harga;
    data['ukuran'] = this.ukuran;
    data['kategori'] = this.kategori;
    data['stok'] = this.stok;
    data['__v'] = this.iV;
    return data;
  }
}
