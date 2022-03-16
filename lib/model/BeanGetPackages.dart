class BeanGetPackages {
  bool status;
  String message;
  List<Data> data;

  BeanGetPackages({this.status, this.message, this.data});

  BeanGetPackages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String packageId;
  String userId;
  String packagename;
  String cuisinetype;
  String mealtype;
  String mealfor;
  String weeklyplantype;
  String monthlyplantype;
  String startdate;
  String includingSaturday;
  String includingSunday;
  String monthlyprice;
  String weeklyprice;
  String createddate;

  Data(
      {this.packageId,
        this.userId,
        this.packagename,
        this.cuisinetype,
        this.mealtype,
        this.mealfor,
        this.weeklyplantype,
        this.monthlyplantype,
        this.startdate,
        this.includingSaturday,
        this.includingSunday,
        this.monthlyprice,
        this.weeklyprice,
        this.createddate});

  Data.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    userId = json['user_id'];
    packagename = json['packagename'];
    cuisinetype = json['cuisinetype'];
    mealtype = json['mealtype'];
    mealfor = json['mealfor'];
    weeklyplantype = json['weeklyplantype'];
    monthlyplantype = json['monthlyplantype'];
    startdate = json['startdate'];
    includingSaturday = json['including_saturday'];
    includingSunday = json['including_sunday'];
    monthlyprice = json['monthlyprice'];
    weeklyprice = json['weeklyprice'];
    createddate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_id'] = this.packageId;
    data['user_id'] = this.userId;
    data['packagename'] = this.packagename;
    data['cuisinetype'] = this.cuisinetype;
    data['mealtype'] = this.mealtype;
    data['mealfor'] = this.mealfor;
    data['weeklyplantype'] = this.weeklyplantype;
    data['monthlyplantype'] = this.monthlyplantype;
    data['startdate'] = this.startdate;
    data['including_saturday'] = this.includingSaturday;
    data['including_sunday'] = this.includingSunday;
    data['monthlyprice'] = this.monthlyprice;
    data['weeklyprice'] = this.weeklyprice;
    data['createddate'] = this.createddate;
    return data;
  }
}
