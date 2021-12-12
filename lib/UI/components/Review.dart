import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:flutter/cupertino.dart';

Widget Review(Map review){

  return Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(
      bottom: 10
    ),
    decoration: BoxDecoration(
      color: UIColors.gray,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            semiHeader(review['user']['name']!=null?review['user']['name']:"Тимофей"),
            Row(
              children: [
                for (int i = 0; i < review['rating']-1; i++)  CachedNetworkImage(imageUrl: "https://www.pngall.com/wp-content/uploads/9/Golden-Star-PNG-Image-File.png", height: 10, width: 10,),
                for (var i = review['rating']; i < 5; i++)  CachedNetworkImage(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Star_empty.svg/471px-Star_empty.svg.png", height: 10, width: 10,),
              ],
            )

          ],
        ),
        SizedBox(height: 7,),
        plainText(review['text'], align: TextAlign.left)
      ],
    )
  );

}