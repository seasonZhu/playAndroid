import 'package:flutter/material.dart';

import 'package:play_android/View/Routes.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _popToRoot(context);
            },
          ),
          title: Text("注册", style: TextStyle(color: Colors.white)),
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
                          onTap: () {},
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
                          "注册并登录",
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

  // 各种pop研究
  void _popToRoot(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(Routes.root));
    //Navigator.pop(context);
    //Navigator.popAndPushNamed(context, "/");
  }
}