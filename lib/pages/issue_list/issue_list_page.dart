import 'package:flutter/material.dart';
import '../../widgets/navigator_bar.dart';
import '../area_list/select_area_page.dart';
class IssueListPage extends StatefulWidget {
  @override
  _IssueListPageState createState() => _IssueListPageState();
}

class _IssueListPageState extends State<IssueListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
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
                callback: (index) {

                },
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
          InkWell(child: Image.asset('assets/image/opz_btn_nav_issue_list_search.png',width: 18,height: 18,),onTap: (){
            print('tap actions');
          },),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: InkWell(child: Image.asset('assets/image/opz_btn_nav_issue_list_message_normal.png',width: 18,height: 18,),onTap: (){
              print('tap actions');
            },),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16,left: 18),
            child: InkWell(child: Image.asset('assets/image/opz_btn_nav_issue_list_new.png',width: 18,height: 18,),onTap: (){
              print('tap actions');
            },),
          ),

//          IconButton(icon: ImageIcon(AssetImage('assets/image/opz_btn_nav_issue_list_search.png'),size: 18,), onPressed: (){
//
//          }),
//          IconButton(icon: ImageIcon(AssetImage('assets/image/opz_btn_nav_issue_list_message_normal.png')), onPressed: (){
//
//          }),
//          IconButton(icon: ImageIcon(AssetImage('assets/image/opz_btn_nav_issue_list_new.png')), onPressed: (){
//
//          }),
        ],
      ),
    );
  }
}
