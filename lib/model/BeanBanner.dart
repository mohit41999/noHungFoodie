// To parse this JSON data, do
//
//     final beanBanner = beanBannerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BeanBanner beanBannerFromJson(String str) =>
    BeanBanner.fromJson(json.decode(str));

String beanBannerToJson(BeanBanner data) => json.encode(data.toJson());

class BeanBanner {
  BeanBanner({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory BeanBanner.fromJson(Map<String, dynamic> json) => BeanBanner(
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
    @required this.orderitemsid,
    @required this.ordertype,
    @required this.packagetype,
    @required this.kitchenName,
    @required this.kitchenMobileno,
    @required this.riderName,
    @required this.riderMobileno,
    @required this.riderRating,
    @required this.riderReview,
    @required this.trackRiderLatitude,
    @required this.trackRiderLongitude,
    @required this.meal,
  });

  String orderitemsid;
  String ordertype;
  String packagetype;
  String kitchenName;
  String kitchenMobileno;
  String riderName;
  String riderMobileno;
  String riderRating;
  String riderReview;
  String trackRiderLatitude;
  String trackRiderLongitude;
  Meal meal;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderitemsid: json["orderitemsid"],
        ordertype: json["ordertype"],
        packagetype: json["packagetype"],
        kitchenName: json["kitchen_name"],
        kitchenMobileno: json["kitchen_mobileno"],
        riderName: json["rider_name"],
        riderMobileno: json["rider_mobileno"],
        riderRating: json["rider_rating"],
        riderReview: json["rider_review"],
        trackRiderLatitude: json["track_rider_latitude"],
        trackRiderLongitude: json["track_rider_longitude"],
        meal: Meal.fromJson(json["meal"]),
      );

  Map<String, dynamic> toJson() => {
        "orderitemsid": orderitemsid,
        "ordertype": ordertype,
        "packagetype": packagetype,
        "kitchen_name": kitchenName,
        "kitchen_mobileno": kitchenMobileno,
        "rider_name": riderName,
        "rider_mobileno": riderMobileno,
        "rider_rating": riderRating,
        "rider_review": riderReview,
        "track_rider_latitude": trackRiderLatitude,
        "track_rider_longitude": trackRiderLongitude,
        "meal": meal.toJson(),
      };
}

class Meal {
  Meal({
    @required this.id,
    @required this.mealplan,
    @required this.referenceId,
    @required this.deliveryDate,
    @required this.deliveryFromtime,
    @required this.plan,
    @required this.itemName,
  });

  String id;
  String mealplan;
  String referenceId;
  String deliveryDate;
  String deliveryFromtime;
  String plan;
  String itemName;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        mealplan: json["mealplan"],
        referenceId: json["reference_id"],
        deliveryDate: (json["delivery_date"]),
        deliveryFromtime: json["delivery_fromtime"],
        plan: json["plan"],
        itemName: json["item_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mealplan": mealplan,
        "reference_id": referenceId,
        "delivery_date": deliveryDate,
        "delivery_fromtime": deliveryFromtime,
        "plan": plan,
        "item_name": itemName,
      };
}
