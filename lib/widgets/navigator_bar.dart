//通用导航栏 默认显示 title backBtn 支持自定义bottom 和 actions
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final String title;
  final Widget titleWidget;
  BuildContext context;
  final List<Widget> actions;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final String backImgName;
  final bool isBack;
  final Widget leading;
  MyAppBar({
    this.bottom,
    this.title,
    this.context,
    this.actions,
    this.titleStyle,
    this.backgroundColor,
    this.backImgName,
    this.isBack: true,
    this.titleWidget,
    this.leading,
  });
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize

  Size get preferredSize => Size.fromHeight(this.bottom != null ? 91 : 45);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.titleWidget ?? new Text(
        widget.title ?? '',
        style: widget.titleStyle ?? new TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,//当leading为null是 leading的位置给title使用  不设置 左边间隙较大
      leading: (widget.isBack ? FlatButton(
        child: Image(
          image: new AssetImage(widget.backImgName ?? 'resources/base_navi_back.png'),
          width: 9,
          height: 15,
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ) : null),
      backgroundColor: widget.backgroundColor ?? Colors.white,
      elevation: 0,

      bottom: new AppBarBottom(
        child: widget.bottom,
      ),
      actions: widget.actions,
    );
  }
}

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  AppBarBottom({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFFE5E5E5),
          ),
          child ??
              SizedBox(
                height: 0,
              ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(this.child != null ? 47 : 1);
}