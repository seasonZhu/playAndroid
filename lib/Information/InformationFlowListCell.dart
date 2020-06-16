import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:play_android/View/Routes.dart';
import 'package:play_android/Responses/DataInfo.dart';

class InformationFlowListCell extends StatelessWidget {
  final DataInfo _model;

  InformationFlowListCell({
    Key key,
    @required DataInfo model,
  })  : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        _pushToWebView(context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: _getRow(),
      ),
    ));
  }

  Widget _imageView() {
    return _model.envelopePic != ""
        ? Container(
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: _model.envelopePic,
              placeholder: (context, url) => Image.asset(
                "assets/images/placeholder.png",
              ),
            ),
            width: 60,
            height: 60,
          )
        : Container();
  }

  Widget _contentView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Html(
              data: _model.title,
              customTextStyle: (node, TextStyle baseStyle) {
                return baseStyle.merge(TextStyle(fontSize: 15));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _model.fresh != null && _model.fresh
                        ? Text(
                            "最新 ",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Container(),
                    _model.type != null && _model.type != 0
                        ? Text(
                            "置顶 ",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Container(),
                    (_model.author.isNotEmpty) || (_model.shareUser.isNotEmpty)
                        ? Text(
                            _model.author ?? _model.shareUser,
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(
                            "收藏集",
                            style: TextStyle(color: Colors.grey),
                          ),
                  ],
                ),
                Text(
                  _model.niceShareDate ?? "好好学习",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getRow() {
    return Row(
      children: <Widget>[
        _imageView(),
        _contentView(),
      ],
    );
  }

  void _pushToWebView(BuildContext context) {
    Navigator.pushNamed(context, Routes.informationFlowWebView,
        arguments: _model);
  }
}
