import 'package:flutter/material.dart';
import '../issue_list/issue_list_page.dart';
import '../order_list/order_list_page.dart';
import '../working_table/working_table_page.dart';
import '../my_profile/my_profile_page.dart';
import 'package:flustars/flustars.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/image/home_task_selected.png')),
      title: Text('工单'),
    ),
    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/image/home_order_selected.png')),
      title: Text('订单'),
    ),
    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/image/home_worktable_selected.png')),
      title: Text('工作台'),
    ),
    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/image/home_mine_selected.png')),
      title: Text('我的'),
    ),

  ];
  final List<Widget> tabBodies = [
    IssueListPage(),
    OrderListPage(),
    WorkingTabelPage(),
    MyProfilePage(),

  ];

  int currentIndex = 0;

  var currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = tabBodies[currentIndex];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Color(0xFF746C5B),
        unselectedItemColor: Color(0xFF999999),
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          color: Color(0xFF333333)
        ),
        unselectedLabelStyle:TextStyle(
            fontSize: 10,
            color: Color(0xFF999999)
        ),
        type: BottomNavigationBarType.fixed,//3个以上才有效果
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (i) {
          setState(() {
            currentIndex = i;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(//保持页面状态 需要用这个  在每个子页面中混入 AutomaticKeepAliveClientMixin  重写wantKeepAlive true
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}