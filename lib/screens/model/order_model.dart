class OrderModel {
  String? code;
  int? id;
  int? idUser;
  String? fullname;
  String? phone;
  String? address;
  OrderStatus? orderStatus;
  OrderPayment? orderPayment;
  int? tempPrice;
  int? shipPrice;
  int? totalPrice;
  String? dateCreated;
  List<Product>? product;

  OrderModel(
      {this.code,
        this.id,
        this.idUser,
        this.fullname,
        this.phone,
        this.address,
        this.orderStatus,
        this.orderPayment,
        this.tempPrice,
        this.shipPrice,
        this.totalPrice,
        this.dateCreated,
        this.product});

  OrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    idUser = json['id_user'];
    fullname = json['fullname'];
    phone = json['phone'];
    address = json['address'];
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
    orderPayment = json['order_payment'] != null
        ? new OrderPayment.fromJson(json['order_payment'])
        : null;
    tempPrice = json['temp_price'];
    shipPrice = json['ship_price'];
    totalPrice = json['total_price'];
    dateCreated = json['date_created'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['address'] = this.address;
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus!.toJson();
    }
    if (this.orderPayment != null) {
      data['order_payment'] = this.orderPayment!.toJson();
    }
    data['temp_price'] = this.tempPrice;
    data['ship_price'] = this.shipPrice;
    data['total_price'] = this.totalPrice;
    data['date_created'] = this.dateCreated;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderStatus {
  String? id;
  String? namevi;
  String? classOrder;

  OrderStatus({this.id, this.namevi, this.classOrder});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namevi = json['namevi'];
    classOrder = json['class_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['namevi'] = this.namevi;
    data['class_order'] = this.classOrder;
    return data;
  }
}

class OrderPayment {
  String? namevi;

  OrderPayment({this.namevi});

  OrderPayment.fromJson(Map<String, dynamic> json) {
    namevi = json['namevi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['namevi'] = this.namevi;
    return data;
  }
}

class Product {
  int? id;
  String? code;
  String? photo;
  String? name;
  String? size;
  String? color;
  int? regularPrice;
  int? salePrice;
  int? quantity;

  Product(
      {this.id,
        this.code,
        this.photo,
        this.name,
        this.size,
        this.color,
        this.regularPrice,
        this.salePrice,
        this.quantity});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    photo = json['photo'];
    name = json['name'];
    size = json['size'];
    color = json['color'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['size'] = this.size;
    data['color'] = this.color;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['quantity'] = this.quantity;
    return data;
  }
}
