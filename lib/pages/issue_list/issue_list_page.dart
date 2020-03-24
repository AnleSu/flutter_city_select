import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opapp/pages/issue_list/filter_page/filter_model.dart';
import 'package:flutter_opapp/pages/issue_list/filter_page/filter_page.dart';
import '../../widgets/navigator_bar.dart';
import '../area_list/select_area_page.dart';
import 'issue_item.dart';

class IssueListPage extends StatefulWidget {
  @override
  _IssueListPageState createState() => _IssueListPageState();
}

class _IssueListPageState extends State<IssueListPage> {
  List<String> _taskNumList = ['145', '7', '14', '0', '0', '0'];
  List<String> _tabList = ['待派发', '待处理', '处理中', '已完成', '已取消', '已终止'];

  Widget _buildAppBar() {
    return MyAppBar(
      isBack: false,
      titleWidget: Padding(
        padding: EdgeInsets.only(left: 15),
        child: InkWell(
          // highlightColor 和 radius 或者highlightColor和splashColor 配合 去掉点击水波纹效果
//            highlightColor: Colors.transparent,
//            radius: 0.0,
          splashColor: Colors.transparent, // 溅墨色（波纹色）
          highlightColor: Colors.transparent, // 点击时的背景色（高亮色）
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SelectAreaPage(
                callback: (index) {},
              );
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
//            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '灯市口区域店(中心店)',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 6,
              ),
              Image.asset(
                'assets/image/opz_btn_nav_issue_list_store_arrow.png',
                width: 20,
                height: 20,
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Image.asset(
              'assets/image/opz_btn_nav_issue_list_search.png',
              width: 18,
              height: 18,
            ),
            onPressed: () {}),
        IconButton(
            icon: Image.asset(
              'assets/image/opz_btn_nav_issue_list_message_normal.png',
              width: 18,
              height: 18,
            ),
            onPressed: () {}),
        PopupMenuButton<String>(
          offset: Offset(0, 70),
          //设置菜单弹出的位置
//              shape: new BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0),side: new BorderSide(
//                style: BorderStyle.none,
//              )),

          itemBuilder: (context) => _getPopupMenu(context),
          onSelected: (String value) {
            print('onSelected $value');
          },
          onCanceled: () {
            print('onCanceled');
          },
          icon: Image.asset(
            'assets/image/opz_btn_nav_issue_list_new.png',
            width: 18,
            height: 18,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(alignment: Alignment.bottomRight, children: <Widget>[
          Column(
            children: <Widget>[
              new Material(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                          child: new TabBar(
                        onTap: (index) {
                          print('tab tap $index');
                        },
                        isScrollable: true,
                        indicatorColor: Color(0xFFFEAB00),
                        indicatorSize: TabBarIndicatorSize.label,
//                          indicatorPadding: EdgeInsets.only(top: 20),
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xFF666666),
                        labelStyle: TextStyle(fontSize: 14),
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                        tabs: _tabList.asMap().keys.map((index) {
                          return new Tab(
                            text: "${_tabList[index]}" +
                                (_taskNumList[index] == '0'
                                    ? ''
                                    : '(${_taskNumList[index]})'),
                          );
                        }).toList(),
                      )),
                      new Padding(
                        padding: EdgeInsets.only(right: 15, left: 10),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          // 溅墨色（波纹色）
                          highlightColor: Colors.transparent,
                          // 点击时的背景色（高亮色）
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 0.5,
                                height: 32,
                                alignment: Alignment.center,
                                color: Color(0xFFE5E5E5),
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                '我的',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Container(
                                width: 5,
                              ),
                              Image.asset(
                                'assets/image/opz_btn_nav_issue_list_store_arrow.png',
                                width: 16,
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return IssueItemWidget();
                  },
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              print('filter');
//                _filterController.show();
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterDialog(
                      filterBuilder: FilterBuilder(
                          filterWidget: FilterPage(
                            typeList: [
                              TaskTypeItemModel(OPZTaskType.OPZTaskTypeAll),
                              TaskTypeItemModel(
                                  OPZTaskType.OPZTaskTypeScheduling),
                              TaskTypeItemModel(OPZTaskType.OPZTaskTypeWash),
                              TaskTypeItemModel(OPZTaskType.OPZTaskTypeFuel),
                              TaskTypeItemModel(
                                  OPZTaskType.OPZTaskTypeVehicleValid),
                              TaskTypeItemModel(
                                  OPZTaskType.OPZTaskTypeUserReportException),
                              TaskTypeItemModel(
                                  OPZTaskType.OPZTaskTypeeVehicleValidDoubt),
                              TaskTypeItemModel(
                                  OPZTaskType.OPZTaskTypeVehicleValidRefuse),
                              TaskTypeItemModel(OPZTaskType
                                  .OPZTaskTypeDropOffDeveiceException),
                            ],
                            soruceList: [
                              TaskSourceItemModel(OPZTaskSource.OPZTaskSourceAll),
                              TaskSourceItemModel(OPZTaskSource.OPZTaskSourceManual),
                              TaskSourceItemModel(OPZTaskSource.OPZTaskSourceOrder),
                            ],
                          ),
                          filterWidgetHeight: 618),
                    );
                  });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15, bottom: 15),
              child: Image.asset('assets/image/opz_btn_issue_list_filiter.png'),
            ),
          )
        ]),
      ),
    );
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: '新建工单',
        child: ListTile(
          title: Text('新建工单'),
          leading: Image.asset(
              'assets/image/opz_btn_issue_list_menu_create_task.png'),
        ),
      ),
      PopupMenuItem<String>(
        value: '开启自动接单',
        child: ListTile(
          title: Text('开启自动接单'),
          leading: Image.asset(
              'assets/image/opz_btn_issue_list_menu_auto_accept.png'),
        ),
      ),
    ];
  }
}
