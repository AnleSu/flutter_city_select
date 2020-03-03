

import 'package:flutter/material.dart';

class IssueItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)), //圆角
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
//      height: 247,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '洗车单',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text('(订单排车)',
                        style:
                            TextStyle(color: Color(0xFF333333), fontSize: 14))
                  ],
                ),
                Text('待处理',
                    style: TextStyle(color: Color(0xFFFEAB00), fontSize: 14)),
              ],
            ),
          ),
          Padding(
            child: Divider(
              height: 1,
              color: Color(0xFFE5E5E5),
              indent: 15,
            ),
            padding: EdgeInsets.only(top: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCustomIconTitleWidget(
                      'assets/image/opz_icon_issue_list_license_plate.png', '京Q E4232'),
                  _buildCustomIconTitleWidget(
                      'assets/image/opz_icon_issue_list_employee.png', '李二狗'),
                  _buildCustomIconTitleWidget(
                      'assets/image/opz_icon_issue_list_store.png', '望京三元桥旗舰店'),
                  _buildCustomIconTitleWidget(
                      'assets/image/opz_icon_issue_list_time.png',
                      '预计取车时间 2019-09-12 12:12'),
                ],
              ),
              Container(

                padding: EdgeInsets.only(right: 15),
                alignment: Alignment.center,
                child: Image.asset('assets/image/opz_icon_issue_list_arrow.png'),
              )

            ],
          ),

          Padding(
            child: Divider(
              height: 1,
              color: Color(0xFFE5E5E5),
              indent: 15,
            ),
            padding: EdgeInsets.only(top: 15),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('12:20 前完成处理'),
                Container(
                  width: 80,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFFEAB00)
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Text('改派',style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCustomIconTitleWidget(String imageStr, String string) {
    return Padding(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Row(
          children: <Widget>[
            Image.asset(
              imageStr,
              width: 14,
              height: 14,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                string,
                style: TextStyle(color: Color(0xFF333333), fontSize: 14),
              ),
            )
          ],
        ));
  }
}
