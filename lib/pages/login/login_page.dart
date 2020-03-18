import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_model.dart';
import '../area_list/select_area_page.dart';

const String kUserLoginStatusKey = 'UserLoginStatus';
const String kUserLoginNameKey = 'kUserLoginNameKey';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //分别定义两个输入框的焦点 用于切换焦点
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodePwd = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _defaultName();

  }
/*查看本地是否有上一次登录保存的数据*/
  void _defaultName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(kUserLoginNameKey)) {
      String defaultName = prefs.getString(kUserLoginNameKey);
      if(defaultName.length > 0) {
        setState(() {
          _nameController.text = defaultName;
        });

      }
    }


  }

  void _verify() {
    String name = _nameController.text;
    print('name $name');
    String password = _passwordController.text;
    print('password $password');
    if (name.isEmpty || name.length < 11) {
      setState(() {
        _isClick = false;
      });
      return;
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    setState(() {
      _isClick = true;
    });
  }

  _login() async {
    print('login action');
    //基本数据类型 持久化
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUserLoginStatusKey, true);
    prefs.setString(kUserLoginNameKey, _nameController.text);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SelectAreaPage();
    }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 120),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                child: Image.asset('assets/Login/opp_icon_login_title.png'),
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: 69,
              ),
              MyTextField(
                prefixIcon: Image.asset('assets/Login/login_account_icon.png'),
                focusNode: _nodeName,
                placeHolder: '请输入优车账号',
                maxLength: 11,
                keyboardType: TextInputType.phone,
                controller: _nameController,
              ),
              SizedBox(
                height: 30,
              ),
              MyTextField(
                prefixIcon: Image.asset('assets/Login/login_password_icon.png'),
                focusNode: _nodePwd,
                placeHolder: '请输入优车密码',
                maxLength: 16,
                controller: _passwordController,
                isInputPwd: true,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '忘记密码？',
                      style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '加盟商账号登录',
                      style: TextStyle(fontSize: 16, color: Color(0xFF5C7DF6)),
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22.5)),
                  color: Color(0xFFFEAB00),
                ),
                child: FlatButton(
                  disabledColor: Color(0xFFDDDDDD),
                  disabledTextColor: Color(0xFFFFFFFF),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22.5))),
                  //必填参数，按下按钮时触发的回调，接收一个方法，传null表示按钮禁用，会显示禁用相关样式
                  onPressed: _isClick ? _login : null,
                  child: Text(
                    '登录',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ]),
            Padding(
              padding: EdgeInsets.only(
                bottom: 28,
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '登录即表示同意',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: '《用户服务协议》',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tap the user protocol');
                              },
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5C7DF6),
                            ),
                            children: <TextSpan>[
                          TextSpan(
                            text: '和',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                            ),
                          ),
                          TextSpan(
                              text: '《运营助手隐私政策》',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5C7DF6),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('tap the op protocol');
                                }),
                        ]))
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
