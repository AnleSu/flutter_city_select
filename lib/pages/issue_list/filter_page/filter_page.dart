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
//      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color(0xFF0E567F).withOpacity(0.1),
              offset: Offset(0.0, 0.0), //阴影xy轴偏移量
              blurRadius: 20.0, //阴影模糊程度
              spreadRadius: 10 //阴影扩散程度
              )
        ],
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
              padding: EdgeInsets.only(
                left: 15,
              ),
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
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeaderView(String sectionTitle) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sectionTitle,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: Divider(
              color: Color(0xFFE5E5E5),
              height: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 25),
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xFF0E567F).withOpacity(0.1),
              offset: Offset(0.0, -1.0), //阴影xy轴偏移量
              blurRadius: 20.0, //阴影模糊程度
              spreadRadius: 10 //阴影扩散程度
              )
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: Color(0xFFDCDFE6), width: 0.5),
            ),
            child: MaterialButton(
              textColor: Colors.black,
              onPressed: () {},
              child: Text(
                '重置',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(//左边重置按钮固定宽度 右边根据屏幕尺寸拉伸
            child: Container(
              margin: EdgeInsets.only(left: 10),
//            width: 205,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xFFFEAB00),
//              border: Border.all(color: Color(0xFFDCDFE6), width: 0.5),
              ),
              child: MaterialButton(
                textColor: Colors.white,
                onPressed: () {},
                child: Text(
                  '确定',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _naviView(),
            _sectionHeaderView('工单类型'),
            _sectionHeaderView('工单来源'),
            _sectionHeaderView('创建时间'),

          ],
        ),
        _bottomBar()
      ]),
    );
  }
}
