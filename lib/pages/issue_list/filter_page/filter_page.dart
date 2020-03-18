

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
              color: Colors.white,
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
  final FilterBuilder filterBuilder;
  FilterPage({this.filterModel, this.filterBuilder});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }







  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
