class News {
  late bool status;
  late int statusCode;
  late String timestamp;
  late String message;
  late Result result;

  News(
      {required this.status,
      required this.statusCode,
      required this.timestamp,
      required this.message,
      required this.result});

  News.fromJson(Map<String, dynamic> json) {
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
  late String judul;
  late String isi;
  late String tanggal;
  late String gambar;
  late int like;

  Data(
      {required this.sId,
      required this.judul,
      required this.isi,
      required this.tanggal,
      required this.gambar,
      required this.like});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    judul = json['judul'];
    isi = json['isi'];
    tanggal = json['tanggal'];
    gambar = json['gambar'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['tanggal'] = this.tanggal;
    data['gambar'] = this.gambar;
    data['like'] = this.like;
    return data;
  }
}
