
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
              Container(width: 6,),
              Image.asset('assets/image/2.0x/opz_btn_nav_issue_list_store_arrow.png',width: 20,height: 20,)
            ],
          ),
        ),
        title: 'jsjfklajsdiofja',
      ),
    );
  }
}

//左侧导航
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

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
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
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
//        var childList = list[index].bxMallSubDto;
//        var categoryId = list[index].mallCategoryId;
//
//        Provide.value<ChildCategory>(context)
//            .getChildCategory(childList, categoryId);
//        setState(() {
//          listIndex = index;
//        });
//
//        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 15, top: 15),
        decoration: BoxDecoration(
          color: isClick ? Colors.white : Color(0xFFF7F7F7),
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text(
          list[index].deptName,
          style: TextStyle(fontSize: 14, color: isClick ? Color(0xFF333333) : Color(0xFF666666)),
        ),
      ),
    );
  }

//  void _getCategory() async {
//    await request('getCategory').then((val) {
//      var data = json.decode(val.toString());
//      CategoryModel category = CategoryModel.fromJson(data);
//      // list.data.forEach((item) => print('${item.mallCategoryName}'));
//      setState(() {
//        list = category.data;
//      });
//      //默认选中第一个
//      Provide.value<ChildCategory>(context)
//          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
//      //先请求category 然后用第一个categoryId 请求goodsList
//      _getGoodsList();
//    });
//  }
//
//  void _getGoodsList({String categoryId, String categorySubId}) async {
//    var data = {
//      'categoryId':
//          Provide.value<ChildCategory>(context).selectCategoryId == null
//              ? '4'
//              : categoryId,
//      'categorySubId': categorySubId,
//      'page': 1
//    };
//    await request('getMallGoods', formData: data).then((val) {
//      var response = json.decode(val.toString());
//      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(response);
//      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(model.data);
//    });
//  }
}
