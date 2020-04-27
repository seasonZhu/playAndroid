import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/RankListResponse.dart';
import 'package:play_android/Responses/ResponseState.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ErrorView.dart';

import 'RankingCell.dart';

/* 
 该页面是新思路和特性的试验田
 我会把想到的思路都在这个页面进行实现,其他页面的改造就会这个页面大同小异
 */
class RankingView extends StatefulWidget {
  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  var _page = 1;

  var _offset = 0.0;

  var _dataSource = List<DataElement>();

  var _refreshController = RefreshController(initialRefresh: false);

  var _scrollController = ScrollController();

  var _value = 0;

  var _body;

  @override
  void initState() {
    super.initState();
    _getRankList(_page);

    // 监听滑动的offset
    _scrollController.addListener(() {
      _offset = _scrollController.offset;
      print("offset: ${_scrollController.offset}");
    });
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: [
        LoadingView(),
        ErrorView(),
        SafeArea(child: _listView(context, _dataSource)),
        EmptyView()
      ],
      index: _value,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("排行榜", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: _body, //_contentView(context, _dataSource),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _contentView(BuildContext context, List<DataElement> dataSoures) {
    if (dataSoures.length == 0) {
      return LoadingView();
    } else {
      return SafeArea(child: _listView(context, dataSoures));
    }
  }

  Widget _listView(BuildContext context, List<DataElement> dataSoures) {
    return SmartRefresher(
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return RankingCell(model: dataSoures[index]);
        },
        itemCount: dataSoures.length,
      ),
    );
  }

  // 由于Flutter的使用会使得iOS中点击statusBar滑动到顶部的方案失效,这个floatButton不思维一直解决方法
  Widget _buildFloatingActionButton() {
    if (_offset <= 120) {
      return Container();
    }

    // 换了一个思路,其实用_page也是可以进行floatButtton设置的
    // if (_page == 0) {
    //   return Container();
    // }

    return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          _scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        });
  }

  Future<RankListResponse> _getRankList(int page) async {
    var model = await Request.getRankingList(page: page);
    if (model.errorCode == 0) {
      if (_page == 1) {
        _dataSource.clear();
      }
      _dataSource.addAll(model.data.datas);
      /* 
        Whether this State object is currently in a tree.
        After creating a State object and before calling initState, 
        the framework "mounts" the State object by associating it with a BuildContext. 
        The State object remains mounted until the framework calls dispose, 
        after which time the framework will never ask the State object to build again.
        It is an error to call setState unless mounted is true.

        mounted是State<T>类中的属性,这里我可以理解为属性页面,tableView.reloadData()
         */
      if (mounted)
        setState(() {
          switch (model.responseState) {
            case ResponseState.loading:
              _value = model.responseState.value;
              break;
            case ResponseState.success:
              _value = model.successState.value;
              break;
            case ResponseState.fail:
              _value = model.responseState.value;
              break;
          }
        });
    }
    return model;
  }

  void _onRefresh() async {
    _page = 1;
    await _getRankList(_page);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page = _page + 1;
    var model = await _getRankList(_page);
    if (model.data.pageCount == model.data.curPage) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  // futureBuilder对于上下拉的还是不太好
  Widget futureBuilder() {
    return FutureBuilder(
        future: _getRankList(_page),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            RankListResponse model = snapshot.data;
            _dataSource.addAll(model.data.datas);
            //发生错误
            if (snapshot.hasError) {
              ToastView.show(model.errorMsg);
            }
            //请求成功，通过项目信息构建用于显示项目名称的ListView
            return _contentView(context, _dataSource);
          }
          //请求未完成时弹出loading
          return LoadingView();
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
