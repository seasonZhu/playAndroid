import 'package:flutter/material.dart';

import 'package:play_android/View/Routes.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("登录", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: '用户名或邮箱',
                        labelText: '用户名',
                        prefixIcon: Icon(Icons.person)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: '密码',
                        labelText: '密码',
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, right: 15),
                        child: GestureDetector(
                          child: Text(
                            "还没有注册?",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15),
                          ),
                          onTap: () {
                            _pushToRegisterView(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Container(
                      width: 400,
                      height: 44,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "登录",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 各种push的研究
  void _pushToRegisterView(BuildContext context) {
    Navigator.pushNamed(context, Routes.registerView);
    //Navigator.pushNamedAndRemoveUntil(context, Routes.registerView, ModalRoute.withName(Routes.loginView));

    //Navigator.pop(context);
    //Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     fullscreenDialog: true,
    //     builder: (context) => RegisterView(),
    //   ),
    // );

    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(fullscreenDialog: true, builder: (BuildContext context) => RegisterView()),
    //   ModalRoute.withName(Routes.loginView),
    // );
  }
}