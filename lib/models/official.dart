class Official {
  late bool status;
  late int statusCode;
  late String timestamp;
  late String message;
  late Result result;

  Official(
      {required this.status,
      required this.statusCode,
      required this.timestamp,
      required this.message,
      required this.result});

  Official.fromJson(Map<String, dynamic> json) {
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
  late String nama;
  late String jabatan;
  late String role;
  late String gambar;
  late bool statusDelete;

  Data(
      {required this.sId,
      required this.nama,
      required this.jabatan,
      required this.role,
      required this.gambar,
      required this.statusDelete});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nama = json['nama'];
    jabatan = json['jabatan'];
    role = json['role'];
    gambar = json['gambar'];
    statusDelete = json['statusDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nama'] = this.nama;
    data['jabatan'] = this.jabatan;
    data['role'] = this.role;
    data['gambar'] = this.gambar;
    data['statusDelete'] = this.statusDelete;
    return data;
  }
}
