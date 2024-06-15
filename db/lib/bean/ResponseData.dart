import 'package:flutter/material.dart';

import 'BannerBean.dart';

class ResponseData {
  List<BannerBean> data;
  int errorCode;
  String errorMsg;

  ResponseData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BannerBean> dataList =
        list.map((i) => BannerBean.fromJson(i)).toList();

    return ResponseData(
      data: dataList,
      errorCode: json['errorCode'] as int,
      errorMsg: json['errorMsg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((v) => v.toJson()).toList(),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}
