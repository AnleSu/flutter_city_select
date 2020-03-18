

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opapp/pages/issue_list/filter_page/filter_model.dart';

class FilterBuilder {
  final Widget filterWidget;
  final double filterWidgetHeight;

  FilterBuilder({this.filterWidget, this.filterWidgetHeight});
}

class FilterDialog extends Dialog {
  final FilterModel filterModel;
  final FilterBuilder filterBuilder;

  FilterDialog({this.filterModel, this.filterBuilder});

  bool _isShowFilter = false;

  @override
  Widget build(BuildContext context) {
    return _buildFilterPageWidget(context);
  }

  Widget _mask(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white12,
      ),
    );
  }

  Widget _buildFilterPageWidget(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            _mask(context),
            Container(
//              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: filterBuilder.filterWidgetHeight,
              child: filterBuilder.filterWidget,
            )
          ],
        ),
      ),
    );
  }
}

class FilterPage extends StatefulWidget {
  final FilterModel filterModel;

  FilterPage({this.filterModel});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _naviView() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      height: 60,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xFF0E567F).withOpacity(0.1),
                offset: Offset(0.0, 30), //阴影xy轴偏移量
                blurRadius: 20.0, //阴影模糊程度
                spreadRadius: 0 //阴影扩散程度
            )
          ],

      ),
      child: Container(

        height: 50,
        decoration: BoxDecoration(

          color: Colors.white,
        ),
        child: Stack(

          alignment: AlignmentDirectional.centerStart, //左中 中右结构
          children: <Widget>[
            Center(
              child: Text(
                "筛选",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, ),
              child: InkWell(
                child: Text(
                  "取消",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
                onTap: () {
                  print('click  cancle');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          _naviView(),
        ],
      ),
    );
  }
}
