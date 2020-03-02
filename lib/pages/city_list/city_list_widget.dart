import 'dart:wasm';

import 'package:flutter/material.dart';
import 'city_list_model.dart';
import 'index_bar.dart';

//支持 索引条 遮罩视图定制 但是写的不好。。。。 数据源控制和点击方法 控制在本类内 只支持定制UI

typedef Widget ItemWidgetBuilder(BuildContext context, CityListModel model);

typedef Widget IndexBarBuilder(
    BuildContext context, List<String> tags, IndexBarTouchCallback onTouch);

typedef Widget IndexHintBuilder(BuildContext context, String hint);

typedef CitySelectedCallback = void Function(CityListModel cityListModel);

class CityListViewHeader {
  CityListViewHeader({
    @required this.height,
    @required this.builder,
    this.firstEnName = "↑",
  });

  final int height;
  final String firstEnName;
  final WidgetBuilder builder;
}

class _HeaderModel extends CityListModel {}

class CityList extends StatefulWidget {
  final List<CityListModel> data;

  final List<CityListModel> topData; //比如头部有热门城市

  final ItemWidgetBuilder itemBuilder;

  final ScrollController controller;

  final ScrollPhysics physics;

  final bool shrinkWrap;

  final EdgeInsetsGeometry padding;

  final IndexBarBuilder indexBarBuilder;

  final IndexHintBuilder indexHintBuilder;

  final int sectionHeight;

  final int itemHeight;

  final CityListViewHeader header;

  final CityListModel selectedCity;

  final TextStyle itemTextStyle;

  final TextStyle itemTextSelectStyle;

  CitySelectedCallback onSelectedCity;

  CityList(
      {Key key,
      this.data,
      this.topData,
      this.itemBuilder,
      this.controller,
      this.physics,
      this.shrinkWrap = true,
      this.padding = EdgeInsets.zero,
      this.indexBarBuilder,
      this.indexHintBuilder,
      this.sectionHeight = 36,
      this.itemHeight = 50,
      this.header,
      this.selectedCity,
      this.onSelectedCity,
      this.itemTextStyle =
          const TextStyle(fontSize: 14, color: Color(0xFF333333)),
      this.itemTextSelectStyle =
          const TextStyle(fontSize: 14, color: Color(0xFFFEAB00))})
      : super(key: key);

  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  Map<String, int> _suspensionSectionMap = Map();
  List<CityListModel> _cityList = List();
  List<String> _indexTagList = List();
  bool _isShowIndexBarHint = false;
  String _indexBarHint = "";
  String _suspensionTag = "";
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  //处理数据 每组第一个才显示组头
  void setShowSuspensionStatus(List<CityListModel> list) {
    if (list == null || list.isEmpty) return;
    String tempTag;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = list[i].getFirstEnName();
      if (tempTag != tag) {
        tempTag = tag;
        list[i].isShowSuspension = true;
      } else {
        list[i].isShowSuspension = false;
      }
    }
  }

  //获取城市首字母数组
  List<String> getFirstEnNameList(List<CityListModel> list) {
    List<String> indexData = new List();
    if (list != null && list.isNotEmpty) {
      String tempTag;
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = list[i].getFirstEnName();
        if (tag.length > 2) tag = tag.substring(0, 2);
        if (tempTag != tag) {
          indexData.add(tag);
          tempTag = tag;
        }
      }
    }
    return indexData;
  }

  void _init() {
    _cityList.clear();
    if (widget.topData != null && widget.topData.isNotEmpty) {
      _cityList.addAll(widget.topData);
    }

    List<CityListModel> list = widget.data;
    if (list != null && list.isNotEmpty) {
      _cityList.addAll(list);
    }

    setShowSuspensionStatus(_cityList);

    if (widget.header != null) {
      _cityList.insert(
          0, _HeaderModel()..firstEnName = widget.header.firstEnName);
    }

    _indexTagList.clear();

    _indexTagList.addAll(getFirstEnNameList(_cityList));
  }

  //索引点击事件
  void _onIndexBarTouch(IndexBarDetails model) {
    setState(() {
      _indexBarHint = model.tag;
      _isShowIndexBarHint = model.isTouchDown;
      //根据 字母 取出对应的偏移量 滑动到对应的位置
      int offset = _suspensionSectionMap[model.tag];
      if (offset != null) {
        _scrollController.jumpTo(offset
            .toDouble()
            .clamp(.0, _scrollController.position.maxScrollExtent));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();

    Widget indexBar; //右侧索引条
    if (widget.indexBarBuilder == null) {
      indexBar = IndexBar(
        data: _indexTagList,
        width: 26,
        onTouch: _onIndexBarTouch,
      );
    } else {
      indexBar = widget.indexBarBuilder(
        context,
        _indexTagList,
        _onIndexBarTouch,
      );
    }

    Widget indexHint; //带字母的遮罩层
    if (widget.indexHintBuilder != null) {
      indexHint = widget.indexHintBuilder(context, '$_indexBarHint');
    } else {
      indexHint = Container(
        decoration: new BoxDecoration(
          //背景
          color: Color(0xFF746C5B),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          //设置四周边框
//            border: new Border.all(width: 1, color: Colors.red),
        ),
        alignment: Alignment.center,
        width: 50.0,
        height: 50.0,
        child: Text(
          '$_indexBarHint',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      );
    }

    //组头视图
    Widget _buildSectionWidget(String tag) {
      return Container(
        height: widget.sectionHeight.toDouble(),
        padding: const EdgeInsets.only(left: 15.0),
        color: Color(0xfff3f4f5),
        alignment: Alignment.centerLeft,
        child: Text(
          '$tag',
          softWrap: false,
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xff999999),
          ),
        ),
      );
    }

    var children = <Widget>[
      SuspensionView(
        data: _cityList,
        contentWidget: ListView.builder(
            controller: _scrollController,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            padding: widget.padding,
            itemCount: _cityList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 && _cityList[index] is _HeaderModel) {
                return SizedBox(
                    height: widget.header.height.toDouble(),
                    child: widget.header.builder(context));
              } else {
                CityListModel model = _cityList[index];

                return Column(
                  children: <Widget>[
                    Offstage(
                      offstage: model.isShowSuspension != true,
                      child: _buildSectionWidget(model.firstEnName),
                    ),
                    SizedBox(
                      height: widget.itemHeight.toDouble(),
                      child: ListTile(
                        trailing: model.cityId == widget.selectedCity.cityId
                            ? Padding(
                                child: Image.asset(
                                  'assets/image/2.0x/opz_newtask_choosed.png',
                                  width: 16,
                                  height: 16,
                                ),
                                padding: EdgeInsets.only(right: 30),
                              )
                            : Container(
                                width: 10,
                              ),
                        title: Text(model.cityName,
                            style: model.cityId == widget.selectedCity.cityId
                                ? widget.itemTextSelectStyle
                                : widget.itemTextStyle),
                        onTap: () {
                          print("OnItemClick: $model");
                          widget.onSelectedCity(model);
                        },
                      ),
                    )
                  ],
                );
              }
            }),
        controller: _scrollController,
        suspensionHeight: widget.sectionHeight,
        onSusSectionInited: (Map<String, int> map) =>
            _suspensionSectionMap = map,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: indexBar,
      ),
      _isShowIndexBarHint
          ? Center(
              child: indexHint,
            )
          : Container()
    ];
    return Stack(
      children: children,
    );
  }
}

/// on all sus section callback(map: Used to scroll the list to the specified tag location).
typedef void OnSusSectionCallBack(Map<String, int> map);

///Suspension Widget.Currently only supports fixed height items!
class SuspensionView extends StatefulWidget {
  /// with  CityListModel Data
  final List<CityListModel> data;

  /// content widget(must contain ListView).
  final Widget contentWidget;

  /// ListView ScrollController.
  final ScrollController controller;

  /// suspension widget Height.
  final int suspensionHeight;

  /// item Height.
  final int itemHeight;

  /// on sus section callback.
  final OnSusSectionCallBack onSusSectionInited;

  final CityListViewHeader header;

  SuspensionView(
      {Key key,
      @required this.data,
      @required this.contentWidget,
      @required this.controller,
      this.suspensionHeight = 40,
      this.itemHeight = 50,
      this.onSusSectionInited,
      this.header})
      : assert(contentWidget != null),
        assert(controller != null),
        super(key: key);

  @override
  _SuspensionWidgetState createState() => new _SuspensionWidgetState();
}

class _SuspensionWidgetState extends State<SuspensionView> {
  int _suspensionTop = 0;
  int _lastIndex;
  int _suSectionListLength;

  List<int> _suspensionSectionList = new List(); //记录每个字母偏移量的数组

  Map<String, int> _suspensionSectionMap = new Map(); //key:每个字母 value:对应的起始偏移量

  @override
  void initState() {
    super.initState();
    if (widget.header != null) {
      _suspensionTop = -widget.header.height;
    }
//    widget.controller.addListener(() {
//      int offset = widget.controller.offset.toInt();
//      int _index = _getIndex(offset);
//
//      if (_index != -1 && _lastIndex != _index) {
//        _lastIndex = _index;
//
//      }
//    });
  }

  int _getIndex(int offset) {
    if (widget.header != null && offset < widget.header.height) {
      if (_suspensionTop != -widget.header.height) {
        setState(() {
          _suspensionTop = -widget.header.height;
        });
      }
      return 0;
    }
    for (int i = 0; i < _suSectionListLength - 1; i++) {
      int space = _suspensionSectionList[i + 1] - offset;
      if (space > 0 && space < widget.suspensionHeight) {
        space = space - widget.suspensionHeight;
      } else {
        space = 0;
      }
      if (_suspensionTop != space) {
        setState(() {
          _suspensionTop = space;
        });
      }
      int a = _suspensionSectionList[i];
      int b = _suspensionSectionList[i + 1];
      if (offset >= a && offset < b) {
        return i;
      }
      if (offset >= _suspensionSectionList[_suSectionListLength - 1]) {
        return _suSectionListLength - 1;
      }
    }
    return -1;
  }

  void _init() {
    _suspensionSectionMap.clear();
    int offset = 0;
    String tag;
    if (widget.header != null) {
      _suspensionSectionMap[widget.header.firstEnName] = 0;
      offset = widget.header.height;
    }
    widget.data?.forEach((v) {
      if (tag != v.getFirstEnName()) {
        tag = v.getFirstEnName();
        _suspensionSectionMap.putIfAbsent(tag, () => offset);
        offset = offset + widget.suspensionHeight + widget.itemHeight;
      } else {
        offset = offset + widget.itemHeight;
      }
    });
    _suspensionSectionList
      ..clear()
      ..addAll(_suspensionSectionMap.values);
    _suSectionListLength = _suspensionSectionList.length;
    if (widget.onSusSectionInited != null) {
      widget.onSusSectionInited(_suspensionSectionMap);
    }
    print(_suspensionSectionMap);
    print(_suspensionSectionList);
  }

  @override
  Widget build(BuildContext context) {
    _init();
    var children = <Widget>[
      widget.contentWidget,
    ];

    return Stack(children: children);
  }
}
