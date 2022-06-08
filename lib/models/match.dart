class Match {
  late bool status;
  late int statusCode;
  late String timestamp;
  late String message;
  late Result result;

  Match(
      {required this.status,
      required this.statusCode,
      required this.timestamp,
      required this.message,
      required this.result});

  Match.fromJson(Map<String, dynamic> json) {
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
  late Klub klub;
  late Logo logo;
  late Skor skor;
  late String stadion;
  late String liga;
  late String tanggal;
  late String jam;
  late String statusPertandingan;
  late bool statusDelete;

  Data(
      {required this.sId,
      required this.klub,
      required this.logo,
      required this.skor,
      required this.stadion,
      required this.liga,
      required this.tanggal,
      required this.jam,
      required this.statusPertandingan,
      required this.statusDelete});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    klub = (json['klub'] != null ? new Klub.fromJson(json['klub']) : null)!;
    logo = (json['logo'] != null ? new Logo.fromJson(json['logo']) : null)!;
    skor = (json['skor'] != null ? new Skor.fromJson(json['skor']) : null)!;
    stadion = json['stadion'];
    liga = json['liga'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    statusPertandingan = json['statusPertandingan'];
    statusDelete = json['statusDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.klub != null) {
      data['klub'] = this.klub.toJson();
    }
    if (this.logo != null) {
      data['logo'] = this.logo.toJson();
    }
    if (this.skor != null) {
      data['skor'] = this.skor.toJson();
    }
    data['stadion'] = this.stadion;
    data['liga'] = this.liga;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['statusPertandingan'] = this.statusPertandingan;
    data['statusDelete'] = this.statusDelete;
    return data;
  }
}

class Klub {
  late String klub1;
  late String klub2;

  Klub({required this.klub1, required this.klub2});

  Klub.fromJson(Map<String, dynamic> json) {
    klub1 = json['klub1'];
    klub2 = json['klub2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['klub1'] = this.klub1;
    data['klub2'] = this.klub2;
    return data;
  }
}

class Logo {
  late String logo1;
  late String logo2;

  Logo({required this.logo1, required this.logo2});

  Logo.fromJson(Map<String, dynamic> json) {
    logo1 = json['logo1'];
    logo2 = json['logo2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo1'] = this.logo1;
    data['logo2'] = this.logo2;
    return data;
  }
}

class Skor {
  late int skor1;
  late int skor2;

  Skor({required this.skor1, required this.skor2});

  Skor.fromJson(Map<String, dynamic> json) {
    skor1 = json['skor1'];
    skor2 = json['skor2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skor1'] = this.skor1;
    data['skor2'] = this.skor2;
    return data;
  }
}
