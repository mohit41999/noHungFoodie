import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/Menu/BasePackagescreen.dart';
import 'package:food_app/Menu/OrderScreen.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TrackDeliveryScreen extends StatefulWidget {
  @override
  _TrackDeliveryScreenState createState() => _TrackDeliveryScreenState();
}
class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(

        backgroundColor:AppConstant.appColor,
        drawer: MyDrawers(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
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
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Image.asset(
                            Res.ic_menu,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                      child: Text(
                        "Track Deliveries",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              height: 70,
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return getItem();
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget getItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
         padding: EdgeInsets.only(left: 16,top: 16),
         child: Text("1234 | 7:30 PM",style: TextStyle(color: Colors.black,fontFamily: AppConstant.fontBold,fontSize: 16),),
       ),

        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16,top: 16),
          child: Text("ORDER BY LOREM IPSUM",style: TextStyle(color: AppConstant.lightGreen,fontFamily: AppConstant.fontBold,fontSize: 14),),
        ),

        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16,top: 16),
              child: Image.asset(Res.ic_loc,width: 16,height: 16,color: AppConstant.lightGreen,)
            ),
            Padding(
              padding: EdgeInsets.only(left: 5,top: 16),
              child: Text("1 214,AB Heights,Manish Nagar\nNagpur-123",style: TextStyle(color: Colors.black,fontFamily: AppConstant.fontRegular,fontSize: 14),),
            ),

          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16,top: 16),
              child: Text("Total Bill:",style: TextStyle(color: Colors.grey,fontFamily: AppConstant.fontRegular,fontSize: 14),),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8,top: 16),
                child: Text(AppConstant.rupee+"213",style: TextStyle(color: Colors.grey,fontFamily: AppConstant.fontRegular,fontSize: 14),),
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                    color: AppConstant.appColor, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Center(
                    child: Text(
                      "TRACK",
                      style: TextStyle(
                          color: Colors.white, fontFamily: AppConstant.fontBold,fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );


  }
}
