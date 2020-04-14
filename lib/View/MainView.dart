import 'package:flutter/material.dart';

import 'package:play_android/Home/HomeView.dart';
import 'package:play_android/Article/ArticleView.dart';
import 'package:play_android/PublicNumber/PublicNumberView.dart';
import 'package:play_android/My/MyView.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final _views = [HomeView(), ArticleView(), PublicNumberView(), MyView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar), title: Text("项目")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), title: Text("公众号")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
        ], 
        currentIndex: _selectedIndex, //默认选中的 index
        fixedColor: Colors.black, //选中时颜色变为黑色
        type: BottomNavigationBarType.fixed, //类型为 fixed
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //刷新界面
    });
  }
}