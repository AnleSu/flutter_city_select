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
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomePageContent();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  Future getHomePageContent() async {
    try {
      print('开始获取友盟数据');
      Response response;
      Dio dio = new Dio();
//      dio.options.contentType =
//          ContentType.parse('application/x-www-form-urlencoded');

      response = await dio.post('http://localhost:8080/api/hello?name=suanle');
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        throw Exception('throw exception');
      }
    } catch (e) {
      return print('error $e');
    }
  }
}
