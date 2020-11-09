import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/View/Routes.dart';
import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/DataInfo.dart';
import 'package:play_android/Responses/ArticleTopListResponse.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
//import 'package:play_android/Compose/EmptyView.dart';

import 'package:play_android/Information/InformationFlowListCell.dart';
import 'package:play_android/Test/View/TestView.dart';
import 'BannerView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  List<DataInfo> _dataSource = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _page = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTopArticleList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("首页", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        /// AppBar颜色渐变
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Color.fromARGB(255, 28, 135, 251), Colors.blueAccent],
            ),
          ),
        ),
        elevation: 0.1,
        /// 自定义抽屉按钮
        leading: Builder(
          builder: (context) => GestureDetector(
            child: Icon(Icons.mail),
            onTap: () => Scaffold.of(context).openDrawer(),
        )),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _pushToHotkeView(context);
              })
        ],
      ),
      body: _body(),
      drawer: TestView(),
    );
  }

  Widget _body() {
    return Container(
      child: _dataSource.length > 0
          ? SmartRefresher(
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                // itemBuilder: (context, index) => Column(
                //   children: <Widget>[
                //     _sectionHeader(index),
                //     InformationFlowListCell(
                //       model: _dataSource[index],
                //     ),
                //   ],
                // ),
                // itemCount: _dataSource.length,
                /// 这样写少包裹了一层Column,但是逻辑变得有些复杂
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _sectionHeader(index);
                  } else {
                    return InformationFlowListCell(
                      model: _dataSource[index - 1],
                    );
                  }
                },
                itemCount: _dataSource.length + 1,
              ),
            )
          : LoadingView(),
    );
  }

  Widget _sectionHeader(int index) {
    if (index == 0) {
      return BannerView();
    }
    return Container();
  }

  void _onRefresh() async {
    _page = 0;
    _getTopArticleList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    var model = await _getArticleList();
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  Future<ArticleTopListResponse> _getTopArticleList() async {
    var model = await Request.getTopArticleList();
    if (model.errorCode == 0) {
      _dataSource.clear();
      _dataSource.addAll(model.data);
      if (mounted) setState(() {});
    } else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  Future<InformationFlowListResponse> _getArticleList() async {
    var model = await Request.getArticleList(page: _page - 1);
    if (model.errorCode == 0) {
      _dataSource.addAll(model.data.datas);
      if (mounted) setState(() {});
    } else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  void _pushToHotkeView(BuildContext context) {
    Navigator.pushNamed(context, Routes.hotKeyView);
  }

  /// 注意这个dispose的调用顺序 this->super
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
