library loading_loading;

import 'dart:async';

import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  static StreamController<bool> controller;
  static bool get isLoading => _isLoading;
  static bool _isLoading = false;

  static void toggle() => setLoading(!_isLoading);
  static void setLoading(bool status) {
    controller.add(status);
    _isLoading = status;
  }

  final Widget loadingWidget;
  final Widget child;

  LoadingWidget({Key key, Widget loading, @required this.child})
      : this.loadingWidget = loading ??
            Container(
              alignment: Alignment.center,
              color: Colors.black38,
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CircularProgressIndicator(),
              ),
            ),
        super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  void initState() {
    super.initState();
    LoadingWidget._isLoading = false;
    LoadingWidget.controller = StreamController<bool>.broadcast();
    LoadingWidget.controller.add(false);
  }

  @override
  void dispose() {
    LoadingWidget.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        StreamBuilder<bool>(
          initialData: false,
          stream: LoadingWidget.controller.stream,
          builder: (context, snapshot) {
            return Visibility(
              visible: snapshot.data,
              child: widget.loadingWidget,
            );
          },
        ),
      ],
    );
  }
}
