import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/cards/AchivementCard.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cards/CollectorCard.dart';
import '../buttons.dart';

Widget CollectorBottomSheet(BuildContext context, CollectorModel collector) {
  double height = displayHeight(context);
  collectorsBloc.loadCollectors();
  return Container(

    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height*0.8
      ),
      child: new Container(
        padding: EdgeInsets.only(top: 23, left: 15, right: 15),
        decoration: BoxDecoration(
            color: UIColors.background,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0))),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: defaultHeader(collector.name),
            ),
            CollectorImage(
              image_url: collector.photo,

            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: CollectorAdress(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: CollectorDescription(description: collector.description),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10,right: 250),
              child: SecondaryButton(
                  child: Text("Контакты",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  onPressed: () {}),
            ),

            Container(
                margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UnicornOutlineButton(
                        strokeWidth: 2,
                        radius: 15,
                        gradient: UIGradients.Main,
                        child: Container(
                          child: Text(
                            "Отметить посещение",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () async{
                          var res = await checkInCollector(collector);
                          if (res['new_achievement']){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => _buildPopupDialogAchivement(context, res['achievement'])
                            );

                          }else{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => _buildPopupDialog(context, res),
                            );
                          }

                        }),
                    StreamBuilder(
                      stream: collectorsBloc.collectors,
                      builder: (BuildContext context, AsyncSnapshot<List<CollectorModel>> snapshot){
                        if (snapshot.hasData) {
                          bool liked = false;
                          for (var i in snapshot.data!){
                            if (i.id == collector.id){
                              liked = i.liked;
                              break;
                            }
                          }
                          return InkWell(
                            onTap: () {
                              collectorsBloc.likeCollector(collector);
                            },
                            child: new Icon(
                              liked ? Icons.favorite : Icons
                                  .favorite_border,
                              color: UIIconColors.active,
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    )
                  ],
                )),
            Container(
              height: 20,
            ),
            DefaultButton(
                child: Text("Маршрут",
                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Container(
              height: 20,
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildPopupDialog(BuildContext context, Map json) {
    double width = displayWidth(context);
    return new AlertDialog(
    backgroundColor: UIColors.background,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
    content: new Container(
      width: width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          defaultHeader("Спасибо!"),
          Container(height: 10,),
          plainText("Отметьтесь еще "+json['to_next'].toString()+" раз(a), чтобы получить очивку.", align:TextAlign.left),
          Container(height: 20,),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10  ,
              right: 10,
              left: 10
            ),
            decoration: BoxDecoration(
              color: UIColors.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                Expanded(
                  flex: json['user_visit_count'],
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: UIGradients.Main,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                ),
                Expanded(
                  flex: json['to_next'],
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                        color: UIColors.background,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(height: 20,),
          Container(
            width: width,
            child: DefaultButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              },
                child: Text(
                    "Закрыть",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  textAlign: TextAlign.center,
                )
            ),
          )
        ],
      ),
    )

  );
}

Widget _buildPopupDialogAchivement(BuildContext context, Map json) {
  double width = displayWidth(context);
  return new AlertDialog(
      backgroundColor: UIColors.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: new Container(
        width: width*0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            defaultHeader("Новая очивка!"),
            Container(

              child: UnicornOutlineButton(
                gradient: UIGradients.Main,
                strokeWidth: 1,
                radius: 18,
                onPressed: (){},
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 28,
                        right: 25,
                        bottom: 25,
                        left: 25
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl: json['image'],
                            placeholder: (context, url)=>plc(),
                          ),
                        ),
                        Container(
                          width: 200,
                            margin: EdgeInsets.symmetric(
                                vertical: 15
                            ),
                            child: miniHeader(json['header'])
                        ),
                        Container(
                          width: 200,
                          child: plainText(json['description']),
                        )
                      ],
                    ),
                  ),
                )
              ),
              margin: EdgeInsets.only(
                  bottom: 20,
                top: 20
              ),
            ),
            Container(height: 20,),
            Container(
              width: width,
              child: DefaultButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
                  child: Text(
                    "Закрыть",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            )
          ],
        ),
      )

  );
}


Widget buildPopupDialog(BuildContext context, Map json) {
  double width = displayWidth(context);
  return new AlertDialog(
      backgroundColor: UIColors.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: new Container(
        width: width*0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            defaultHeader("Спасибо!"),
            Container(height: 10,),
            plainText("Отметьтесь еще "+json['to_next'].toString()+" раз(a), чтобы получить очивку.", align:TextAlign.left),
            Container(height: 20,),
            Container(
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10  ,
                  right: 10,
                  left: 10
              ),
              decoration: BoxDecoration(
                  color: UIColors.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: json['user_visit_count'],
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                          gradient: UIGradients.Main,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),
                  ),
                  Expanded(
                    flex: json['to_next'],
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                          color: UIColors.background,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(height: 20,),
            Container(
              width: width,
              child: DefaultButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
                  child: Text(
                    "Закрыть",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            )
          ],
        ),
      )

  );
}

Widget PopupDialog(BuildContext context,  Widget child) {
  double width = displayWidth(context);
  return new AlertDialog(
      backgroundColor: UIColors.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: new Container(
        width: width*0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            defaultHeader("Выберите нужное"),
            Container(

              child: UnicornOutlineButton(
                  gradient: UIGradients.Main,
                  strokeWidth: 1,
                  radius: 18,
                  onPressed: (){},
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 28,
                          right: 25,
                          bottom: 25,
                          left: 25
                      ),
                      child: child
                    ),
                  )
              ),
              margin: EdgeInsets.only(
                  bottom: 20,
                  top: 20
              ),
            ),
            Container(height: 20,),
            Container(
              width: width,
              child: DefaultButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
                  child: Text(
                    "Закрыть",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            )
          ],
        ),
      )

  );
}