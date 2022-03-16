import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanAddCart.dart';
import 'package:food_app/model/BeanFavKitchen.dart';
import 'package:food_app/model/BeanKitchenDetail.dart';
import 'package:food_app/model/BeanRemoveKitchen.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetCartCount.dart';
import 'package:food_app/model/GetHomeData.dart' as home;
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/PackageDetailScreen.dart';
import 'package:food_app/screen/ShippingScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class DetailsScreen extends StatefulWidget {
  home.Data result;

  DetailsScreen(this.result);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  var cuisine = 1;
  var isSelectFood = 1;
  var isSelect = 1;
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  var username = "";
  var email = "";
  var kitchenName = "";
  var mealFor = "";
  var foodtype = "";
  var address = "";
  var type = "";
  var timing = "";
  bool isLike = false;
  bool isDislike = true;
  var open_status = "";
  var total_review = "";
  var avg_review = "";
  List<Offer> offer = [];
  List<Menu> menu = [];
  TabController _controller;
  Future future;
  Future futureCart;
  var cartCount = "";

  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    Future.delayed(Duration.zero, () {
      future = kithchenDetail(context);
      getCartCount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.network(widget.result.image,
                        width: double.infinity, fit: BoxFit.cover),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Padding(
                              padding: EdgeInsets.only(left: 16, top: 26),
                              child: Image.asset(
                                Res.ic_back,
                                color: Colors.white,
                                width: 16,
                                height: 16,
                              )),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        InkWell(
                          onTap: () async {
                            var data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ShippingScreen(
                                        address, widget.result.kitchenId)));
                            if (data != null) {
                              getCartCount(context);
                            }
                          },
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.only(top: 36),
                            decoration: BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                )),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16, right: 6),
                                  child: Image.asset(
                                    Res.ic_bascket,
                                    width: 16,
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Text(
                                    cartCount.isNotEmpty ? cartCount : "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 6),
                                  child: Image.asset(
                                    Res.ic_chef,
                                    width: 80,
                                    height: 80,
                                  )),
                              Expanded(
                                child: SizedBox(
                                  height: 10,
                                ),
                              ),
                              Stack(
                                children: [
                                  widget.result.isFavourite == "0"
                                      ? InkWell(
                                          onTap: () {
                                            addFavKitchen();
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(top: 1),
                                              child: Image.asset(
                                                Res.ic_like,
                                                width: 70,
                                                height: 70,
                                              )),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            removeFav();
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 1, right: 16),
                                              child: Image.asset(
                                                Res.ic_hearfille,
                                                width: 20,
                                                height: 20,
                                              )),
                                        ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //collapsedHeight: 100,
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Name Of Kitchen",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    kitchenName,
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstant.appColor),
                        borderRadius: BorderRadius.circular(50)),
                    width: 80,
                    height: 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            total_review,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Image.asset(
                              Res.ic_star,
                              width: 10,
                              height: 10,
                            )),
                        Padding(
                          child: Text(
                            "(" + avg_review + ")",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                      ],
                    ))
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Image.asset(
                      Res.ic_location,
                      width: 16,
                      height: 16,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    address,
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 15,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Image.asset(
                      Res.ic_time_circle,
                      width: 16,
                      height: 16,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    timing,
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 15,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Open Now",
                    style: TextStyle(
                        color: Color(0xff7EDABF),
                        fontSize: 15,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            ),
            Container(
                height: 55,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return getOffer(offer[index]);
                    },
                    itemCount: offer.length)),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Select Meal Plan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 1;
                        kithchenDetail(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: isSelect == 1
                              ? AppConstant.appColor
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(13)),
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Weekly",
                          style: TextStyle(
                              color:
                                  isSelect == 1 ? Colors.white : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 2;
                        kithchenDetail(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: isSelect == 2
                              ? AppConstant.appColor
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(13)),
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Monthly",
                          style: TextStyle(
                              color:
                                  isSelect == 2 ? Colors.white : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 3;
                        kithchenDetail(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: isSelect == 3
                              ? AppConstant.appColor
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(13)),
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Trial Meal",
                          style: TextStyle(
                              color:
                                  isSelect == 3 ? Colors.white : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Meal Type",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, top: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectFood = 1;
                          kithchenDetail(context);
                        });
                      },
                      child: Card(
                        color: isSelectFood == 1
                            ? Color(0xff7EDABF)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 100,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Image.asset(
                                  Res.ic_veg,
                                  width: 16,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Veg",
                                    style: TextStyle(
                                        color: isSelectFood == 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 11),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectFood = 2;
                          kithchenDetail(context);
                        });
                      },
                      child: Card(
                        color: isSelectFood == 2
                            ? Color(0xff7EDABF)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 150,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image.asset(
                                  Res.ic_chiken,
                                  width: 16,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    "Non-veg",
                                    style: TextStyle(
                                        color: isSelectFood == 2
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 11),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectFood = 3;
                          kithchenDetail(context);
                        });
                      },
                      child: Card(
                        color: isSelectFood == 3
                            ? Color(0xff7EDABF)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 100,
                            child: Row(
                              children: [
                                Image.asset(
                                  Res.ic_vegnonveg,
                                  width: 16,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    "Veg/Non-veg",
                                    style: TextStyle(
                                        color: isSelectFood == 3
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 11),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 6),
              child: Text(
                "Menu",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              child: Container(
                                child: TabBar(
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Colors.black,
                                  indicatorColor: AppConstant.appColor,
                                  isScrollable: false,
                                  controller: _controller,
                                  tabs: [
                                    Tab(text: 'BreakFast'),
                                    Tab(text: 'Lunch'),
                                    Tab(text: 'Dinner'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            Center(
                child: Text(
              "Select your weekly or monthly meal from below",
              style: TextStyle(fontSize: 11),
            )),
            Center(
                child: Text(
              "OR",
              style: TextStyle(fontSize: 11),
            )),
            InkWell(
                onTap: () {},
                child: Center(
                    child: Text(
                  "CUSTOMIZED YOUR MENU",
                  style:
                      TextStyle(fontSize: 11, fontFamily: AppConstant.fontBold),
                ))),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    menu.isEmpty
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getBreakfast(menu[index]);
                            },
                            itemCount: menu.length,
                          ),
                    menu.isEmpty
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GetLunch((menu[index]));
                            },
                            itemCount: menu.length,
                          ),
                    menu.isEmpty
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getDinner(menu[index]);
                            },
                            itemCount: menu.length,
                          ),
                  ],
                ),
              ),
            ),

            /*   Flexible(
              child: Container(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[

                    Column(
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap:(){

                              Navigator.pushNamed(context, '/addpackage');
                              },
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return getLunch();
                              },
                              itemCount: 10,
                            ),
                          ),
                        ),],
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getBreakfast();
                      },
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget getOffer(Offer offer) {
    return Container(
      margin: EdgeInsets.only(left: 6, right: 6, top: 16),
      height: 40,
      width: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppConstant.appColor)),
      child: Center(
        child: Text(
          offer.discount.toString() + "%off " + offer.offercode,
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  Widget getBreakfast(Menu menu) {
    mealFor = "breakfast";
    print(menu);
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Image.asset(
                    Res.ic_poha,
                    width: 60,
                    height: 60,
                  )),

              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        menu.itemname,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 16),
                      )),
                  Text(
                    menu.cuisinetype,
                    style: TextStyle(color: Color(0xffA7A8BC)),
                  ),
                  Text(
                    "₹" + menu.itemprice,
                    style: TextStyle(color: Color(0xff7EDABF)),
                  ),
                  RatingBarIndicator(
                    rating: 4,
                    itemCount: 5,
                    itemSize: 16.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              )),
              InkWell(
                onTap: () {
                  addToCart(menu.itemid, menu.bookType);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppConstant.appColor),
                      borderRadius: BorderRadius.circular(100)),
                  height: 30,
                  width: 70,
                  child: Center(
                    child: Text(
                      "Add+",
                      style:
                          TextStyle(color: AppConstant.appColor, fontSize: 13),
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(right: 16),
              //   decoration: BoxDecoration(
              //     color: AppConstant.appColor,
              //       borderRadius: BorderRadius.circular(100)),
              //   height: 30,
              //   width: 70,
              //   child:Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       InkWell(
              //         child: Text(
              //           "-",
              //           style: TextStyle(color: Colors.white, fontSize: 26),
              //         ),
              //         onTap: (){
              //           if (menu.count > 1) {
              //             setState(() {
              //               menu.count--;
              //
              //                type="minus";
              //
              //
              //             });
              //             updateCart(menu.count);
              //           }
              //         },
              //       ),
              //       Text(
              //         menu.count.toString(),
              //         style: TextStyle(color: Colors.white, fontSize: 13),
              //       ),
              //
              //       InkWell(
              //         onTap: (){
              //           if (menu.count>= 0) {
              //             setState(() {
              //               menu.count++;
              //               type="plus";
              //
              //             });
              //           }
              //           updateCart(menu.count);
              //
              //         },
              //         child: Text(
              //           "+",
              //           style: TextStyle(color: Colors.white, fontSize: 18),
              //         ),
              //       ),
              //     ],
              //   )
              // ),
            ],
          ),
        ],
      ),
    );
  }

/*

  Widget getLunch() {
    return  Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 16),
                  child: Image.asset(
                    Res.ic_veg,
                    width: 30,
                    height: 30,
                  )),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 6,top: 10),
                    child: Text(
                      "Package 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    )),
              ),
              Text(
                "₹3,000",
                style: TextStyle(color: Color(0xff7EDABF)),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,top: 6),
            child: Text(
              "South indian",
              style: TextStyle(color: Color(0xffA7A8BC),fontSize: 13,fontFamily: AppConstant.fontRegular),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,top: 5),
            child: Text(
              "Including Saturday, Sunday",
              style: TextStyle(color: Color(0xffA7A8BC),fontSize: 13,fontFamily: AppConstant.fontRegular),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: RatingBarIndicator(
              rating: 4,
              itemCount: 5,
              itemSize: 16.0,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
*/

  Future<KitchenDetail> kithchenDetail(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();

      FormData from = FormData.fromMap({
        "kitchenid": widget.result.kitchenId,
        "token": "123456789",
        "meal_plan": isSelect == 1
            ? "weekly"
            : isSelect == 2
                ? "monthly"
                : isSelect == 3
                    ? "trial"
                    : "weekly",
        "meal_type": isSelectFood == 1
            ? "0"
            : isSelectFood == 2
                ? "1"
                : isSelectFood == 2
                    ? "2"
                    : "",
        "meal_for": mealFor == "breakfast"
            ? "0"
            : mealFor == "lunch"
                ? "1"
                : mealFor == "dinner"
                    ? "2"
                    : "0"
      });
      print("mealll" + mealFor);
      print("kkk" + widget.result.kitchenId);
      print("kitchenid>>" + isSelectFood.toString());
      print("isSelect>" + isSelect.toString());
      KitchenDetail bean = await ApiProvider().kitchenDetail(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        kitchenName = bean.data[0].kitchenname;
        foodtype = bean.data[0].foodtype;
        address = bean.data[0].address;
        timing = bean.data[0].timing;
        open_status = bean.data[0].openStatus;
        total_review = bean.data[0].totalReview;
        avg_review = bean.data[0].avgReview.toString();
        offer = bean.data[0].offers;
        print("offer" + bean.data[0].offers.toString());

        if (menu != null) {
          menu = bean.data[0].menu;
        }
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

  void addFavKitchen() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.id,
        "token": "123456789",
        "kitchenid": widget.result.kitchenId
      });
      BeanFavKitchen bean = await ApiProvider().favKitchen(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          Utils.showToast(bean.message);
          Navigator.pop(context, true);
        });
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  void removeFav() async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.id,
        "token": "123456789",
        "kitchenid": widget.result.kitchenId
      });
      BeanRemoveKitchen bean = await ApiProvider().removeKitchen(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          Utils.showToast(bean.message);

          Navigator.pop(context, true);
        });
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  getCartCount(BuildContext context) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data.id,
        "token": "123456789",
      });
      print(from);
      GetCartCount bean = await ApiProvider().getCartCount(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        cartCount = bean.data.cartCount.toString();
        setState(() {});
        return bean;
      } else {
        setState(() {
          cartCount = "";
        });
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

  addToCart(String itemid, String bookType) async {
    progressDialog = ProgressDialog(context);
    progressDialog.show();
    try {
      BeanVerifyOtp user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": user.data.id,
        "token": "123456789",
        "kitchen_id": widget.result.kitchenId,
        "type_id": itemid,
        "mealplan": bookType,
        "quantity": "1",
        "quantity_type": "1"
      });

      print("itemId>>" + itemid);
      BeanAddCart bean = await ApiProvider().addCart(from);
      progressDialog.dismiss();
      print(bean.data);
      if (bean.status == true) {
        progressDialog.dismiss();
        Utils.showToast(bean.message);
        getCartCount(context);

        return bean;
      } else {
        Utils.showToast(bean.message);
      }
      return null;
    } on HttpException catch (exception) {
      print(exception);
      progressDialog.dismiss();
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  Widget GetLunch(Menu menu) {
    mealFor = "lunch";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Image.asset(
              Res.ic_veg,
              width: 16,
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 6),
              child: Text(
                menu.itemname,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 16),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                AppConstant.rupee + menu.itemprice,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 6),
          child: Text(
            menu.cuisinetype,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontRegular,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 6),
          child: Text(
            menu.including != null ? menu.including : "",
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontRegular,
                fontSize: 12),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PackageDetailScreen(
                        menu.itemid, menu.itemname, menu.bookType)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 16, top: 6),
                child: Text(
                  "View Details",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppConstant.appColor,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getDinner(Menu menu) {
    mealFor = "dinner";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Image.asset(
              Res.ic_veg,
              width: 16,
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 6),
              child: Text(
                menu.itemname,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 16),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                AppConstant.rupee + menu.itemprice,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 16),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 6),
          child: Text(
            menu.cuisinetype,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontRegular,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 6),
          child: Text(
            menu.including != null ? menu.including : "",
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontRegular,
                fontSize: 12),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PackageDetailScreen(
                        menu.itemid, menu.itemname, menu.bookType)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 16, top: 6),
                child: Text(
                  "View Details",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppConstant.appColor,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
