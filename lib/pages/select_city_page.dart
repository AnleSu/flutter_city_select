import 'dart:convert';

import 'package:flutter/material.dart';
import '../widgets/navigator_bar.dart';
import 'city_list/city_list_model.dart';
import 'package:flutter/services.dart';
import 'city_list/city_list_widget.dart';

import 'package:lpinyin/lpinyin.dart';

class SelectCityPage extends StatefulWidget {
  @override
  _SelectCityPageState createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  List<CityListModel> _cityList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('assets/json/city_data.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['cityList'];
      list.forEach((value) {
        _cityList.add(CityListModel.fromJson(value));
      });
      _handleList(_cityList);
      setState(() {
      });
    });
  }

  void _handleList(List<CityListModel> list) {
    if (list == null || list.isEmpty) return;

    //根据A-Z排序
    list.sort((a, b) {
      return a.getFirstEnName().compareTo(b.getFirstEnName());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          isBack: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15, top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '取消',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'PingFangSC-Regular', //字体可能需要导入字体包 并在yaml中声明
                      color: Color(0xFF333333)),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[

            Expanded(
              flex: 1,
              child: CityList(
                data: _cityList,
                selectedCity: CityListModel(cityId: "35"),
              ),
            ),
          ],
        ));
  }
}
