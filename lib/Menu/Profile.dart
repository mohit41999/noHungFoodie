import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanAddOrder.dart';
import 'package:food_app/model/BeanKitchenDetail.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetActiveOrder.dart' as order;
import 'package:food_app/model/GetProfile.dart';
import 'package:food_app/model/GetUserAddress.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/ActivePackageHistoryScreen.dart';
import 'package:food_app/screen/FavOrderScreen.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/screen/LoginSignUpScreen.dart';
import 'package:food_app/screen/wallet.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;
  ProgressDialog progressDialog;
  var username = "";
  var email = "";
  var wallet = "";
  var number = "";
  var kitchenName = "";
  var foodtype = "";
  var address = "";
  var timing = "";
  var open_status = "";
  var total_review = "";
  var avg_review = "";
  Future future;
  Future _future;
  var like = false;
  var disLike = true;
  BeanVerifyOtp userBean;

  void getUser() async {
    userBean = await Utils.getUser();
    number = userBean.data.mobilenumber;

    setState(() {});
  }
  @override
  initState() {
    getUser();
    super.initState();
    Future.delayed(Duration.zero, () {
      apiCall();
    });

    // if(isLogined){
    //
    // }else{
    //    Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => LoginSignUpScreen()
    //       ),
    //       ModalRoute.withName("/loginSignUp")
    //   );
    // }
  }



  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        drawer: MyDrawers(),
        key: _scaffoldKey,
        body: Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: AppConstant.appColor,
                        margin: EdgeInsets.only(top: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _scaffoldKey.currentState.openDrawer();
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 26),
                                  child: Image.asset(
                                    Res.ic_menu,
                                    width: 30,
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                        height: 150,
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 120),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 56, top: 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        Res.ic_email,
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        email,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: AppConstant.fontBold,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 1, top: 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        Res.ic_phone,
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: AppConstant.fontBold,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => Wallet(wallet)));

                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Res.ic_wallet,
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "My Wallet",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: AppConstant.fontBold,
                                            fontSize: 15),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            "₹" + wallet,
                                            style: TextStyle(
                                                fontFamily: AppConstant.fontBold,
                                                fontSize: 15,
                                                color: Color(0xff7EDABF)),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Res.ic_location,
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Address list",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: AppConstant.fontBold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: FutureBuilder<GetUserAddress>(
                                    future: future,
                                    builder: (context, projectSnap) {
                                      print(projectSnap);
                                      if (projectSnap.connectionState ==
                                          ConnectionState.done) {
                                        var result;
                                        if (projectSnap.data != null) {
                                          result = projectSnap.data.data;
                                          if (result != null) {
                                            print(result.length);
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return getUserAddressList(
                                                    result[index]);
                                              },
                                              itemCount: result.length,
                                            );
                                          }
                                        }
                                      }
                                      return Container(
                                          child: Center(
                                              child:Text("No Address Found")));
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Res.ic_income,
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Manage Payment",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: AppConstant.fontRegular,
                                          fontSize: 15),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Res.ic_help,
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Help",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: AppConstant.fontRegular,
                                          fontSize: 15),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 16, bottom: 16),
                                child: InkWell(
                                  onTap: () {
                                    logout(context);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Res.ic_log,
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Logout",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: AppConstant.fontRegular,
                                            fontSize: 15),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 80, left: 16),
                          child: Image.asset(
                            Res.ic_boy,
                            width: 80,
                            height: 80,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text("Active Orders"),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FavOrderScreen()));
                           },
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            "Favorite Orders",
                            style: TextStyle(color: Color(0xffA7A8BC)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                  children: [
                    FutureBuilder<order.GetActiveOrder>(
                        future: _future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data.data;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getActveOrder(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(
                              child: Center(child: Text("No Address Found")));
                        }),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/customerfeedback');
                              },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(bottom: 8, right: 16),
                          child: Image.asset(
                            Res.ic_chat,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                  ),
                ],
              ),
            ),

          ],
        )


    );
  }

  Widget getActveOrder(order.Data result) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ActivePackageHistoryScreen(result.orderid,result.kitchenname,result.address)));

      },
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  Image.asset(
                    Res.kitchen,
                    width: 50,
                    height: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 6),
                          child: Text(
                            result.kitchenname,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 4),
                          child: Text(
                            result.orderfrom,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            "Customized",
                            style: TextStyle(
                                color: AppConstant.appColor, fontSize: 12),
                          ),
                        ),
                        Divider(
                          color: Color(0xffA7A8BC),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Today Lunch Menu",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16, top: 6),
                      child: Image.asset(
                        Res.ic_breakfast,
                        width: 20,
                        height: 20,
                      )),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 6),
                      child: Text(
                        result.orderItems,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16, top: 6),
                      child: Image.asset(
                        Res.ic_location,
                        width: 20,
                        height: 20,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 6),
                    child: Text(
                      result.address,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 0,
                    ),
                  ),
                  Visibility(
                    visible: disLike,
                    child: InkWell(
                      onTap: () {
                        addFavOrder(result.orderid);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Image.asset(
                          Res.ic_deslike,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: like,
                    child: InkWell(
                      onTap: () {
                        removeFavOrder(result.orderid);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Image.asset(
                          Res.ic_like,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Color(0xffA7A8BC),
              ),
            ],
          )),
    );
  }

  Future<GetProfile> getProfile(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"user_id": user.data.id, "token": "123456789"});
      GetProfile bean = await ApiProvider().getProfile(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          username = bean.data[0].username;
          email = bean.data[0].email;
          wallet = bean.data[0].myWallet;
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  Future<KitchenDetail> kithchenDetail(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "kitchenid": user.data.kitchenid,
        "token": "123456789",
        "meal_plan": "weekly",
        "meal_type": user.data.mealtype,
        "meal_for": "1"
      });
      KitchenDetail bean = await ApiProvider().kitchenDetail(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          kitchenName = bean.data[0].kitchenname;
          foodtype = bean.data[0].foodtype;
          address = bean.data[0].address;
          timing = bean.data[0].timing;
          open_status = bean.data[0].openStatus;
          total_review = bean.data[0].totalReview;
          avg_review = bean.data[0].avgReview.toString();
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  Future<GetUserAddress> getAddressUserAddress(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data.id,
      });
      GetUserAddress bean = await ApiProvider().getUserAddress(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {});
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  getUserAddressList(result) {
    return Padding(
      padding: EdgeInsets.only(left: 46, top: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            Res.ic_location,
            width: 16,
            height: 16,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              result.address.toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              style:
                  TextStyle(fontFamily: AppConstant.fontRegular, fontSize: 15),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 10,
            ),
          ),
        ],
      ),
    );
  }

  Future<order.GetActiveOrder> getActiveOrder(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data.id,
      });
      order.GetActiveOrder bean = await ApiProvider().getActiveOrder(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {});
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  Future<void> logout(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout!'),
          content: const Text('Are you sure want to logout'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                PrefManager.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/loginSignUp', (Route<dynamic> route) => false);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> apiCall() async {
    bool isLogined = await PrefManager.getBool(AppConstant.session);

    if (isLogined) {
      getProfile(context);
      kithchenDetail(context);
      future = getAddressUserAddress(context);
      _future = getActiveOrder(context);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
          ModalRoute.withName("/loginSignUp"));
    }
  }

  addFavOrder(String orderid) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data.id,
        "orderid": orderid,
      });
      print("ordeidd"+orderid);
      print("hgh"+user.data.id);
      BeanAddOrder bean = await ApiProvider().addFavOrder(from);
      progressDialog.dismiss();
      print(bean.data);

      if (bean.status == true) {
        setState(() {
          like = true;
          disLike = false;
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  removeFavOrder(String orderid) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data.id,
        "orderid": orderid,
      });
      BeanAddOrder bean = await ApiProvider().removeFavOrder(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast("Remove Favourite Order");

        setState(() {
          disLike = true;
          like = false;
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }
}
