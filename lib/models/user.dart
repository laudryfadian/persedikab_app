class User {
  User({
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

  User.fromJson(Map<String, dynamic> json) {
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
  late final Data data;

  Result.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.nama,
    required this.email,
    required this.nohp,
    required this.password,
    required this.jk,
    required this.ttl,
    required this.alamat,
    required this.isBlock,
    required this.isVerify,
  });
  late final String id;
  late final String nama;
  late final String email;
  late final String nohp;
  late final String password;
  late final String jk;
  late final String ttl;
  late final String alamat;
  late final bool isBlock;
  late final bool isVerify;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nama = json['nama'];
    email = json['email'];
    nohp = json['nohp'];
    password = json['password'];
    jk = json['jk'];
    ttl = json['ttl'];
    alamat = json['alamat'];
    isBlock = json['isBlock'];
    isVerify = json['isVerify'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nama'] = nama;
    _data['email'] = email;
    _data['nohp'] = nohp;
    _data['password'] = password;
    _data['jk'] = jk;
    _data['ttl'] = ttl;
    _data['alamat'] = alamat;
    _data['isBlock'] = isBlock;
    _data['isVerify'] = isVerify;
    return _data;
  }
}
