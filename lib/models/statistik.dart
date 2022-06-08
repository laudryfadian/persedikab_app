class Statistik {
  late bool status;
  late int statusCode;
  late String timestamp;
  late String message;
  late Result result;

  Statistik(
      {required this.status,
      required this.statusCode,
      required this.timestamp,
      required this.message,
      required this.result});

  Statistik.fromJson(Map<String, dynamic> json) {
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
  late int menang;
  late int kalah;
  late int match;
  late int goal;

  Data(
      {required this.sId,
      required this.menang,
      required this.kalah,
      required this.match,
      required this.goal});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    menang = json['menang'];
    kalah = json['kalah'];
    match = json['match'];
    goal = json['goal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['menang'] = this.menang;
    data['kalah'] = this.kalah;
    data['match'] = this.match;
    data['goal'] = this.goal;
    return data;
  }
}
