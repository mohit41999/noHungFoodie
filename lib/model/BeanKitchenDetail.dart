// To parse this JSON data, do
//
//     final kitchenDetail = kitchenDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KitchenDetail kitchenDetailFromJson(String str) =>
    KitchenDetail.fromJson(json.decode(str));

String kitchenDetailToJson(KitchenDetail data) => json.encode(data.toJson());

class KitchenDetail {
  KitchenDetail({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory KitchenDetail.fromJson(Map<String, dynamic> json) => KitchenDetail(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    @required this.kitchenId,
    @required this.kitchenname,
    @required this.foodtype,
    @required this.address,
    @required this.timing,
    @required this.openStatus,
    @required this.totalReview,
    @required this.avgReview,
    @required this.isFavourite,
    @required this.offers,
    @required this.menu,
  });

  String kitchenId;
  String kitchenname;
  String foodtype;
  String address;
  String timing;
  String openStatus;
  String totalReview;
  int avgReview;
  String isFavourite;
  List<Offer> offers;
  List<Menu> menu;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kitchenId: json["kitchen_id"],
        kitchenname: json["kitchenname"],
        foodtype: json["foodtype"],
        address: json["address"],
        timing: json["timing"],
        openStatus: json["open_status"],
        totalReview: json["total_review"],
        avgReview: json["avg_review"],
        isFavourite: json["is_favourite"],
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "kitchenname": kitchenname,
        "foodtype": foodtype,
        "address": address,
        "timing": timing,
        "open_status": openStatus,
        "total_review": totalReview,
        "avg_review": avgReview,
        "is_favourite": isFavourite,
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    @required this.itemid,
    @required this.bookType,
    @required this.itemname,
    @required this.cuisinetype,
    @required this.including,
    @required this.itemprice,
  });

  String itemid;
  String bookType;
  String itemname;
  String cuisinetype;
  String including;
  String itemprice;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        itemid: json["itemid"],
        bookType: json["book_type"],
        itemname: json["itemname"],
        cuisinetype: json["cuisinetype"],
        including: json["including"],
        itemprice: json["itemprice"],
      );

  Map<String, dynamic> toJson() => {
        "itemid": itemid,
        "book_type": bookType,
        "itemname": itemname,
        "cuisinetype": cuisinetype,
        "including": including,
        "itemprice": itemprice,
      };
}

class Offer {
  Offer({
    @required this.offercode,
    @required this.discounttype,
    @required this.discount,
  });

  String offercode;
  String discounttype;
  int discount;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offercode: json["offercode"],
        discounttype: json["discounttype"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "offercode": offercode,
        "discounttype": discounttype,
        "discount": discount,
      };
}
