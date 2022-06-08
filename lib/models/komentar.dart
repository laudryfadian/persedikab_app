class Komentar {
  late bool status;
  late int statusCode;
  late String timestamp;
  late String message;
  late Result result;

  Komentar(
      {required this.status,
      required this.statusCode,
      required this.timestamp,
      required this.message,
      required this.result});

  Komentar.fromJson(Map<String, dynamic> json) {
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
  late Users users;
  late Beritas beritas;
  late String isi;
  late bool statusDelete;
  late int iV;

  Data(
      {required this.sId,
      required this.users,
      required this.beritas,
      required this.isi,
      required this.statusDelete,
      required this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    users = (json['users'] != null ? new Users.fromJson(json['users']) : null)!;
    beritas = (json['beritas'] != null
        ? new Beritas.fromJson(json['beritas'])
        : null)!;
    isi = json['isi'];
    statusDelete = json['statusDelete'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    if (this.beritas != null) {
      data['beritas'] = this.beritas.toJson();
    }
    data['isi'] = this.isi;
    data['statusDelete'] = this.statusDelete;
    data['__v'] = this.iV;
    return data;
  }
}

class Users {
  late String sId;
  late String nama;

  Users({required this.sId, required this.nama});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nama'] = this.nama;
    return data;
  }
}

class Beritas {
  late String sId;
  late String judul;

  Beritas({required this.sId, required this.judul});

  Beritas.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    judul = json['judul'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['judul'] = this.judul;
    return data;
  }
}
