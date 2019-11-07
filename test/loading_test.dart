import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loading_loading/loading_widget.dart';

void main() {
  LoadingWidget loadingWidget;
  setUp(() {
    loadingWidget = LoadingWidget(child: Container());
    loadingWidget.createState()..initState();
  });

  group('Functions to alter loading', () {
    test('- setLoading Test', () {
      expect(LoadingWidget.controller.stream, emitsInOrder([true, false]));
      LoadingWidget.setLoading(true);
      LoadingWidget.setLoading(false);
    });

    test('- toggle Test', () {
      expect(LoadingWidget.controller.stream, emitsInOrder([true, false]));
      LoadingWidget.toggle();
      LoadingWidget.toggle();
    });
  });

  group('isLoading variable in', () {
    test('- setLoading true Test', () {
      LoadingWidget.setLoading(true);
      expect(LoadingWidget.isLoading, true);
    });

    test('- setLoading false Test', () {
      LoadingWidget.setLoading(false);
      expect(LoadingWidget.isLoading, false);
    });

    test('- toggle Test', () {
      var val = LoadingWidget.isLoading;
      LoadingWidget.toggle();
      expect(LoadingWidget.isLoading, !val);
    });
  });
}
