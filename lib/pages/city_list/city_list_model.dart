import 'package:flutter/widgets.dart';
///**
//    城市id
// */
//@property (nonatomic, copy) NSString *cityId;
//
///**
//    拼音
// */
//@property (nonatomic, copy) NSString *firstEnName;
//
///**
//    城市名称
// */
//@property (nonatomic, copy) NSString *cityName;

class CityListModel {
  String cityId;
  String firstEnName;
  String cityName;
  bool isShowSuspension;//是否显示悬浮的字母  每个字母组里面的第一个是true

  CityListModel({
    this.cityId,
    this.firstEnName,
    this.cityName,
    this.isShowSuspension = false
  });

  CityListModel.fromJson(Map<String, dynamic> json)
  {
    cityName = json['cityName'] == null ? "" : json['cityName'];
    firstEnName = json['firstEnName'] == null ? "" : json['firstEnName'];
    cityId = json['cityId'] == null ? "" : json['cityId'];
  }

  Map<String, dynamic> toJson() => {
    'cityName': cityName,
    'cityId': cityId,
    'firstEnName': firstEnName,
  };

  String getFirstEnName() {
    return this.firstEnName;
  }

}