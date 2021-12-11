import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/material.dart';

class CollectorCard extends StatelessWidget {
  CollectorModel collector;

  CollectorCard({required this.collector});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        collectorsBloc.addActive(collector);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: UIColors.cardBackground,
            borderRadius: BorderRadius.all(
                Radius.circular(20)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultHeader(collector.name),
            Container(
              width: 250,
              margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10
              ),
              child: CollectorAdress(adress: collector.adress),
            ),
            CollectorImage(image_url: collector.photo)
          ],
        ),
      ),
    );
  }
}

Widget CollectorAdress({dynamic adress}) {
  return Container(

      child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.location_pin,
            color: Colors.white,
          ),
        ),),
      Expanded(
        flex: 14,
        child: Align(
          child: Container(
            margin: EdgeInsets.only(
                left: 3
            ),
            child: Text(adress!=null ? adress : " Москва, Автозаводская ул., 18",
                style: TextStyle(
                    color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
          ),
          alignment: Alignment.centerLeft,
        ),),

    ],
  ));
}


Widget CollectorDescription({required String description}){
  return Container(
    child: Text(
      description,
      style: TextStyle(
        color: Colors.white,
         fontSize: 18,
          fontWeight: FontWeight.w500
        )
      )
  );
}

Widget CollectorImage({required String image_url}){
  return Container(
    height: 120,
    decoration: BoxDecoration(
      color: const Color(0xff000),
      borderRadius: BorderRadius.all(Radius.circular(10)),

    ),
    child: Opacity(
      opacity: 0.7,
      child: ClipRRect(

          child:CachedNetworkImage(
        fit: BoxFit.fitWidth,
      imageUrl: image_url,
        placeholder: (context, url)=>plc(),
    ),
        borderRadius: BorderRadius.circular(8.0),
      ),)

  );
}

Widget plc( ){
  return Center(
    child: Container(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        color: UIIconColors.active,
      ),
    ),
  );
}