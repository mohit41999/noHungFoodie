import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/UpdateMenuDetails.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class KitchenDetailScreen extends StatefulWidget {
  @override
  _KitchenDetailScreenState createState() => _KitchenDetailScreenState();
}

class _KitchenDetailScreenState extends State<KitchenDetailScreen> {
  var timeFrom = TextEditingController();
  var timeTo = TextEditingController();
  int _radioValue = -1;
  Future future;
  List<String> food = [];
  List<String> day = [];
  List<String> meal = [];
 var type1="";
 var typ2="";
 var type3="";
 bool checkMeals=false;
 bool checkFood=false;
 bool checkDays=false;

  ProgressDialog progressDialog;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          setState(() {});
          break;

        case 1:
          setState(() {});
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 1, top: 40),
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        Res.ic_right_arrow,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Kitchens Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Type of Firm",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  new Radio(
                    value: 0,
                    groupValue: _radioValue,
                    activeColor: Color(0xff7EDABF),
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Credit/Debit card',
                    style: new TextStyle(
                        fontSize: 14, fontFamily: AppConstant.fontRegular),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    activeColor: Color(0xff7EDABF),
                    onChanged: _handleRadioValueChange,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Kitchen only for delivery',
                      style: new TextStyle(
                          fontSize: 14, fontFamily: AppConstant.fontRegular),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "What type of food you provide",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(choices.length, (index) {
                    return getTypeOfFood(choices[index], index);
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Operation Timings of kitchen",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          "Time From",
                          style: TextStyle(color: AppConstant.appColor),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Padding(
                            padding: EdgeInsets.only(left: 16, top: 16),
                            child: TextField(
                              controller: timeFrom,
                              decoration: InputDecoration(hintText: "00:00"),
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50, top: 16),
                        child: Text(
                          "Time To",
                          style: TextStyle(color: AppConstant.appColor),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Padding(
                            padding: EdgeInsets.only(left: 50, top: 16),
                            child: TextField(
                              controller: timeTo,
                              decoration:
                              InputDecoration(hintText: "00:00"),
                            )),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Operation Day & Respective Timings",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 1,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(days.length, (index) {
                    return getDays(days[index], index);
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Type Of Meals you",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Container(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 1,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(meals.length, (index) {
                    return getMeals(meals[index], index);
                  }),
                ),
              ),
              InkWell(
                onTap: () {
                  validatin();
                },
                child: Container(
                  height: 55,
                  margin:
                  EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }


  void validatin() {
    var time = timeFrom.text.toString();
    var timeto = timeTo.text.toString();
    if (_radioValue == -1) {
      Utils.showToast("Please add type of firm");
    }
    else if (time.isEmpty) {
      Utils.showToast("Please add form time");
    }
    else if (timeto.isEmpty) {
      Utils.showToast("Please add to time");
    }
    else {

      apiCall(time, timeto);

    }
  }

  Future<UpdateMenuDetail> updateMenuSetting(String time, String timeto, bool checkFood, bool checkMeals, bool checkDays
      ) async {
    progressDialog =ProgressDialog(context);
        progressDialog.show();


    try {
      BeanVerifyOtp user=await Utils.getUser();
      FormData data = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data.id,
        "type_of_firm": _radioValue == 0 ? "0" : "1",
        "type_of_food": json.encode(food.toString()),
        "from_time": time.toString(),
        "to_time": timeto.toString(),
        "open_days": json.encode(day.toString()),
        "type_of_meals": json.encode(meal.toString()),
      });
      UpdateMenuDetail bean = await ApiProvider().updateMenuSetting(data);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        Navigator.pop(context,true);

      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
    } catch (exception) {
      progressDialog.dismiss();
    }
  }

  Widget getTypeOfFood(Choice choic, int index) {
    return
      Row(
        children: [
          Checkbox(
            activeColor: Color(0xff7EDABF),
            onChanged: (value) {
              setState(() {
                choic.isChecked = value;
              });
            },
            value: choic.isChecked == null ? false : choic.isChecked,
          ),
          Text(
            choic.title,
            style: TextStyle(
                color: Colors.black,
                fontFamily: AppConstant.fontRegular,
                fontSize: 14),),
        ],
      );
  }

  Widget getDays(Days day, int index) {
    return (Row(
      children: [
        Checkbox(
          activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              day.isCheckedDays = value;
            });
          },
          value: day.isCheckedDays == null ? false : day.isCheckedDays,
        ),
        Text(
          day.title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 14),),
      ],
    )
    );
  }

  Widget getMeals(Meals meals, int index) {
    return Row(
      children: [
        Checkbox(
          activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              meals.isCheckedMeals = value;
            });
          },
          value: meals.isCheckedMeals == null ? false : meals.isCheckedMeals,
        ),
        Text(
          meals.title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 14),),
      ],

    );
  }

  void apiCall(String time, String timeto) {
    choices.forEach((data){
      if(data.isChecked){
        food.add(data.title);
        print("food"+food.toString());
        type1="first";
        checkFood=data.isChecked;
      }
    }
    );
    days.forEach((data){
      if(data.isCheckedDays){
        day.add(data.title);
        print("day"+day.toString());
        typ2="second";
        checkDays=data.isCheckedDays;
      }
    });
    meals.forEach((data){
      if(data.isCheckedMeals){
        meal.add(data.title);
        checkMeals=data.isCheckedMeals;
        type3="third";
      }
    });
    if(type1=="first"&&typ2=="second"&&type3=="third"){
      updateMenuSetting(time, timeto,checkFood,checkMeals,checkDays);
      checkMeals=false;


    }else{
      Utils.showToast("Please check types");
    }

  }
}

class Choice {
  Choice({this.title, this.isChecked});
  String title;
  bool isChecked = false;
}

List<Choice> choices = <Choice>[
  Choice(title: 'North Indian Meals',isChecked: false),
  Choice(title: 'South Indian Meals',isChecked: false),
  Choice(title: 'Diet Meals',isChecked:false),
];

class Days {
  Days({this.title, this.isCheckedDays});
  String title;
  bool isCheckedDays = false;
}

List<Days> days = <Days>[
  Days(title: 'Sunday',isCheckedDays:false),
  Days(title: 'Monday',isCheckedDays:false),
  Days(title: 'Tuesday',isCheckedDays:false),
  Days(title: 'Wednesday',isCheckedDays:false),
  Days(title: 'Thursday',isCheckedDays:false),
  Days(title: 'Friday',isCheckedDays:false),
  Days(title: 'Saturday',isCheckedDays:false),
];


class Meals {
  Meals({this.title, this.isCheckedMeals});
  String title;
  bool isCheckedMeals = false;
}

List<Meals> meals = <Meals>[
  Meals(title: 'Breakfast',isCheckedMeals:false),
  Meals(title: 'Lunch',isCheckedMeals:false),
  Meals(title: 'Dinner',isCheckedMeals:false),
  Meals(title: 'Veg',isCheckedMeals:false),
  Meals(title: 'Non-Veg',isCheckedMeals:false),
];
