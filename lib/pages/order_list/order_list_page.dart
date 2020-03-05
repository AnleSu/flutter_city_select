import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }


  Future getHomePageContent() async {
    try {
      print('开始获取首页主题内容');
      Response response;
      Dio dio = new Dio();
//      dio.options.contentType =
//          ContentType.parse('application/x-www-form-urlencoded');
      var formData = {
        'lon': '115.02932',
        'lat': '35.78189',
      };
      response = await dio.post('', data: formData);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('throw exception');
      }
    } catch (e) {
      return print('error $e');
    }
  }
}
