import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:microer/common/api.dart' as api;
import 'package:microer/common/funs.dart';
import 'package:microer/common/logger.dart';
import 'package:microer/models/status.dart';

class StatusList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  bool _isRefresh = false;
  bool _isLoading = false;

  var _statuses = <Status>[];

  num _total = 0;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  void _retrieveData() {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    api.homeTimeline().then((res) {
      _isLoading = false;
      var body = Statuses.fromJsonMap(res.data);
      _statuses.insertAll(_statuses.length - 1, body.statuses);
      _total += body.totalNumber;
      setState(() {
        _statuses = _statuses;
      });
    }).catchError((error) {
      logger.e(error);
      showToast('授权过期！');
      _isLoading = false;
    });
  }

  Future _handlerRefresh() async {
    if (_isRefresh) {
      return;
    }
    _isRefresh = true;
    api.homeTimeline().then((res) {
      _isRefresh = false;
      var body = Statuses.fromJsonMap(res.data);
      _total = body.totalNumber;
      setState(() {
        _statuses = body.statuses;
      });
    }).catchError((error) {
      logger.e(error);
      showToast('授权过期！');
      _isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: _buildListView(),
      onRefresh: _handlerRefresh,
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: _statuses.length,
        itemBuilder: (context, index) {
          // 如果到了表尾
          if (index == _total-1) {
            //不足100条，继续获取数据
            if (_statuses.length - 1 < 100) {
              //获取数据
              _retrieveData();
              //加载时显示loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              );
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ));
            }
          }
          return ListTile(title: Text(_statuses[index].text));
        });
  }
}
