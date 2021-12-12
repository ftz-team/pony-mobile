import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/reviewsBotoomSheet.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Checkout/CheckoutPage.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/washesApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ServicePriceCard.dart';
import 'WashPrice.dart';
import 'WashRaiting.dart';

class WashPage extends StatefulWidget{
  WashModel wash;
  WashPage({required this.wash});
  WashPageState createState() => WashPageState(wash: this.wash);
}

class WashPageState extends State<WashPage>{
  WashModel wash;
  WashPageState({required this.wash});

  dynamic reviews = [];


  @override
  void initState() {
    getReviews(wash.id).then((value) => this.setState(() {
      reviews = value;
      print(reviews);
    }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = displayHeight(context);
    double width = displayWidth(context);
    return Scaffold(
        backgroundColor : UIColors.darkenBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor : UIColors.background,
          elevation: 0.0,
          title:Container(

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: new Icon(
                      Icons.arrow_back,
                      color : UIIconColors.active,
                    ),
                  ),

                ]
            ),
          ),
        ),
        body: Container(
          width: width,

          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15
                ),
                decoration: BoxDecoration(
                    color: UIColors.background,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(125.0),
                            ),
                            builder: (context) {
                              return ReviewsBottomSheet(context,reviews,wash.id);
                            });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultHeader(
                            wash.name ,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              WashRaiting(wash.rating),
                              SizedBox(
                                width: 5,
                              ),
                              WashPrice(wash.price_level),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                       InkWell(
                         child: Icon(
                           Icons.favorite,
                           color: UIIconColors.active,
                         ),
                       ),
                        SizedBox(
                          height: 5,
                        ),


                      ],
                    )
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [

                    Container(
                      height: 20,
                    ),
                    Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                      child: CollectorImage(
                        image_url: wash.image,
                      ),
                    ),

                    Container(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Expanded(child: CollectorAdress(
                          adress: wash.address
                        ),flex: 2,),
                        Expanded(child: UnicornOutlineButton(strokeWidth: 1, radius: 18, gradient: UIGradients.Main, child: Container(
                          child: plainText("Маршрут"),
                        ), onPressed: (){
                          MapUtils.openMap(wash.point.lat, wash.point.long);

                        }), flex: 1,)
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    semiHeader(wash.description,align: TextAlign.left),
                    Container(
                      height: 10,
                    ),
                    defaultHeader("Прайс"),
                    Container(
                      height: 15,
                    ),
                    for (var service in wash.services) Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: ServicePriceCard(service),
                    ),
                    Container(
                      height: 30,
                    ),
                    DefaultButton(
                        child: Text("Записаться",
                          style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {

                          Navigator.push(context, new CupertinoPageRoute(builder: (context) => CheckoutPage(wash: wash)));
                          navigationBloc.setTab(1);

                        }),
                  ],
                ),
              ),


            ],
          ),
        )
    );
  }
}