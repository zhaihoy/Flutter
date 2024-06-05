import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RadiusImg {
  static Widget get(String imgUrl, double imgW, {double? imgH, Color? shadowColor, double? elevation, double radius = 6.0, RoundedRectangleBorder? shape}) {
    shadowColor ??= Colors.transparent;
    print("zhy"+imgUrl);

    return Card(
      //影音海报
      shape:shape?? RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      color: shadowColor,
      clipBehavior: Clip.antiAlias,
      elevation: elevation == null ? 0.0 : 5.0,
      child: CachedNetworkImage(
        width: imgW,
        height: imgH,
        imageUrl: "http://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1355152571.6.webp",
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
