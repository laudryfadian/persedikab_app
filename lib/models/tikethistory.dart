class TrxTiketHistory {
  TrxTiketHistory({
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

  TrxTiketHistory.fromJson(Map<String, dynamic> json) {
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
    required this.users,
    required this.orderId,
    required this.grossAmount,
    required this.paymentType,
    required this.status,
    required this.tanggal,
    required this.tiketCode,
    required this.paymentDetails,
    required this.customerDetails,
    required this.itemDetails,
  });
  late final String id;
  late final Users users;
  late final String orderId;
  late final int grossAmount;
  late final String paymentType;
  late final String status;
  late final String tanggal;
  late final List<String> tiketCode;
  late final PaymentDetails paymentDetails;
  late final CustomerDetails customerDetails;
  late final ItemDetails itemDetails;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    users = Users.fromJson(json['users']);
    orderId = json['order_id'];
    grossAmount = json['gross_amount'];
    paymentType = json['payment_type'];
    status = json['status'];
    tanggal = json['tanggal'];
    tiketCode = List.castFrom<dynamic, String>(json['tiket_code']);
    paymentDetails = PaymentDetails.fromJson(json['payment_details']);
    customerDetails = CustomerDetails.fromJson(json['customer_details']);
    itemDetails = ItemDetails.fromJson(json['item_details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['users'] = users.toJson();
    _data['order_id'] = orderId;
    _data['gross_amount'] = grossAmount;
    _data['payment_type'] = paymentType;
    _data['status'] = status;
    _data['tanggal'] = tanggal;
    _data['tiket_code'] = tiketCode;
    _data['payment_details'] = paymentDetails.toJson();
    _data['customer_details'] = customerDetails.toJson();
    _data['item_details'] = itemDetails.toJson();
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.nama,
    required this.nohp,
    required this.alamat,
  });
  late final String id;
  late final String nama;
  late final String nohp;
  late final String alamat;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nama = json['nama'];
    nohp = json['nohp'];
    alamat = json['alamat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nama'] = nama;
    _data['nohp'] = nohp;
    _data['alamat'] = alamat;
    return _data;
  }
}

class PaymentDetails {
  PaymentDetails({
    required this.transactionId,
    required this.transactionTime,
    required this.transactionStatus,
    required this.vaNumbers,
    required this.currency,
    required this.fraudStatus,
    required this.merchantId,
    required this.isBuy,
  });
  late final String transactionId;
  late final String transactionTime;
  late final String transactionStatus;
  late final List<VaNumbers> vaNumbers;
  late final String currency;
  late final String fraudStatus;
  late final String merchantId;
  late final bool? isBuy;

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    transactionTime = json['transaction_time'];
    transactionStatus = json['transaction_status'];
    vaNumbers = List.from(json['va_numbers'])
        .map((e) => VaNumbers.fromJson(e))
        .toList();
    currency = json['currency'];
    fraudStatus = json['fraud_status'];
    merchantId = json['merchant_id'];
    isBuy = json['is_buy'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transaction_id'] = transactionId;
    _data['transaction_time'] = transactionTime;
    _data['transaction_status'] = transactionStatus;
    _data['va_numbers'] = vaNumbers.map((e) => e.toJson()).toList();
    _data['currency'] = currency;
    _data['fraud_status'] = fraudStatus;
    _data['merchant_id'] = merchantId;
    _data['is_buy'] = isBuy;
    return _data;
  }
}

class VaNumbers {
  VaNumbers({
    required this.bank,
    required this.vaNumber,
  });
  late final String bank;
  late final String vaNumber;

  VaNumbers.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    vaNumber = json['va_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bank'] = bank;
    _data['va_number'] = vaNumber;
    return _data;
  }
}

class CustomerDetails {
  CustomerDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
  late final String name;
  late final String email;
  late final String phone;
  late final String address;

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['address'] = address;
    return _data;
  }
}

class ItemDetails {
  ItemDetails({
    required this.idTiket,
    required this.price,
    required this.quantity,
    required this.name,
  });
  late final IdTiket idTiket;
  late final int price;
  late final int quantity;
  late final String name;

  ItemDetails.fromJson(Map<String, dynamic> json) {
    idTiket = IdTiket.fromJson(json['idTiket']);
    price = json['price'];
    quantity = json['quantity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idTiket'] = idTiket.toJson();
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['name'] = name;
    return _data;
  }
}

class IdTiket {
  IdTiket({
    required this.id,
    required this.judul,
    required this.stadion,
    required this.jam,
    required this.tanggal,
    required this.jenis,
  });
  late final String id;
  late final String judul;
  late final String stadion;
  late final String jam;
  late final String tanggal;
  late final String jenis;

  IdTiket.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    judul = json['judul'];
    stadion = json['stadion'];
    jam = json['jam'];
    tanggal = json['tanggal'];
    jenis = json['jenis'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['judul'] = judul;
    _data['stadion'] = stadion;
    _data['jam'] = jam;
    _data['tanggal'] = tanggal;
    _data['jenis'] = jenis;
    return _data;
  }
}
