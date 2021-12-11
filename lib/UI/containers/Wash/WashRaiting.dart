import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:flutter/material.dart';

Widget WashRaiting(double raiting){
  return Row(
    children: [
      plainText(raiting.toString()),
      CachedNetworkImage(imageUrl: "https://www.pngall.com/wp-content/uploads/9/Golden-Star-PNG-Image-File.png", height: 10, width: 10,)

    ],
  );
}