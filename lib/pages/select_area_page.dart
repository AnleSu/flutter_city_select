import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/navigator_bar.dart';
import 'area_list/area_list_model.dart';
import 'select_city_page.dart';

class SelectAreaPage extends StatefulWidget {
  @override
  _SelectAreaPageState createState() => _SelectAreaPageState();
}

class _SelectAreaPageState extends State<SelectAreaPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SelectCityPage();
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '北京市',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 6,
              ),
              Image.asset(
                'assets/image/2.0x/opz_btn_nav_issue_list_store_arrow.png',
                width: 20,
                height: 20,
              )
            ],
          ),
        ),
        title: 'jsjfklajsdiofja',
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(
              callback: (index) {
                print(index);
              },

            ),
            RightDeptList(callback: (index) {
              print(index);
            },),
          ],
        ),
      ),
    );
  }
}

//左侧导航
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key, this.callback}) : super(key: key);
  final Function callback;

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<DeptList> list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
          color: Color(0xFFF7F7F7)
//          border: Border(right: BorderSide(width: 1, color: Colors.black12))
      ),
      child: ListView.builder(
//        itemCount: list.length,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(index) {
    bool isClick = false;
    isClick = (index == listIndex);
    return InkWell(
      onTap: () {
        widget.callback(index);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 15, top: 15),
        decoration: BoxDecoration(
          color: isClick ? Colors.white : Color(0xFFF7F7F7),
          border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
        ),
        child: Text(
//          list[index].deptName,
          '北京租车管理部',
          style: TextStyle(
              fontSize: 14,
              color: isClick ? Color(0xFF333333) : Color(0xFF666666)),
        ),
      ),
    );
  }
}

class RightDeptList extends StatelessWidget {
  final String choosedDeptId;
  final List<DeptList> list;
  final Function callback;

  RightDeptList({this.choosedDeptId, this.callback, this.list});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(
        width: 245,
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12)),
            color: Colors.white
        ),

        child: ListView.builder(
//        itemCount: list.length,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return _rightInkWell(index);
          },
        ),
      ),
    );
    ;
  }

  Widget _rightInkWell(index) {
    bool isClick = false;
//    isClick = (list[index].deptId == this.choosedDeptId);
    return InkWell(
      onTap: () {
        this.callback(index);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 20,),
        decoration: BoxDecoration(
          color: Colors.white,
//          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: ListTile(
          trailing: isClick
              ? Padding(
            child: Image.asset(
              'assets/image/2.0x/opz_newtask_choosed.png',
              width: 16,
              height: 16,
            ),
            padding: EdgeInsets.only(right: 15),
          )
              : Container(
            width: 10,
          ),
          title: Text(
            '灯市口区域①店',
            style: TextStyle(
                color: isClick ? Color(0xFFFEAB00) : Color(0xFF333333)),
          ),
        ),
      ),
    );
  }
}
