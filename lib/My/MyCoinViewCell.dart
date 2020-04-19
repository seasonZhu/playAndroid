import 'package:flutter/material.dart';

import 'package:play_android/Responses/MyCoinResponse.dart';
import 'package:play_android/Compose/Space.dart';

class MyCoinViewCell extends StatelessWidget {
  final DataElement _model;

  MyCoinViewCell({
    Key key,
    @required DataElement model,
  })  : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(_model.reason),
          ),
          Container(
            child: Text(_model.desc),
          ),
          Space(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(_model.coinCount.toString()),
          ),
        ],
      ),
    );
  }
}
