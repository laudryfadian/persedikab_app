class Tiket {
  Tiket({
    required this.status,
    required this.statusCode,
    required this.timestamp,
    required this.message,
    required this.result,
  });
  late final bool status;
  late final int statusCode;
  late final String timestamp;
  late final String message;
  late final Result result;

  Tiket.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    message = json['message'];
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['statusCode'] = statusCode;
    _data['timestamp'] = timestamp;
    _data['message'] = message;
    _data['result'] = result.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.data,
  });
  late final List<Data> data;

  Result.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.judul,
    required this.harga,
    required this.stadion,
    required this.jam,
    required this.tanggal,
    required this.jenis,
    required this.stok,
  });
  late final String id;
  late final String judul;
  late final int harga;
  late final String stadion;
  late final String jam;
  late final String tanggal;
  late final String jenis;
  late final int stok;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    judul = json['judul'];
    harga = json['harga'];
    stadion = json['stadion'];
    jam = json['jam'];
    tanggal = json['tanggal'];
    jenis = json['jenis'];
    stok = json['stok'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['judul'] = judul;
    _data['harga'] = harga;
    _data['stadion'] = stadion;
    _data['jam'] = jam;
    _data['tanggal'] = tanggal;
    _data['jenis'] = jenis;
    _data['stok'] = stok;
    return _data;
  }
}
