import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void OnBannerClickListener(int index, dynamic itemData);
typedef Widget BuildShowView(int index, dynamic itemData);

class BannerView<T> extends StatefulWidget {
  final OnBannerClickListener onBannerClickListener;

  //延迟多少秒进入下一页
  final int delayTime; //秒
  //滑动需要秒数
  final int scrollTime; //毫秒
  final double height;
  final List data;
  final BuildShowView buildShowView;

  final ValueChanged<T> onPageChanged;

  BannerView(
      {Key key,
      @required this.data,
      @required this.buildShowView,
      this.onBannerClickListener,
      this.delayTime = 3,
      this.scrollTime = 200,
      this.onPageChanged,
      this.height = 200.0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
//  double.infinity
  var pageController;
  Timer timer;

  BannerViewState() {
//    print(widget.delayTime);
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: widget.data.length);
    resetTimer();
  }

  resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(seconds: widget.delayTime),
        (Timer timer) {
      if (pageController.positions.isNotEmpty) {
        var i = pageController.page.toInt() + 1;
        pageController.animateToPage(i == widget.data.length ? 0 : i,
            duration: new Duration(milliseconds: widget.scrollTime),
            curve: Curves.linear);
      }
    });
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        height: widget.height,
        child: widget.data.length == 0
            ? null
            : new GestureDetector(
                onTap: () {
//            print(pageController.page);
//            print(pageController.page.round());
                  widget.onBannerClickListener(pageController.page.round(),
                      widget.data[pageController.page.round()]);
                },
                onTapDown: (details) {
//            print('onTapDown');
                  clearTimer();
                },
                onTapUp: (details) {
//            print('onTapUp');
                  resetTimer();
                },
                onTapCancel: () {
                  resetTimer();
                },
                child: new PageView.builder(
                  controller: pageController,
                  onPageChanged: (int index) {
                    if (widget.data.length > index && index >= 0) {
                      widget.onPageChanged(widget.data[index]);
                    } else {
                      widget.onPageChanged(null);
                    }
                  },
                  physics: const PageScrollPhysics(
                      parent: const ClampingScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    return widget.buildShowView(index, widget.data[index]);
                  },
                  itemCount: widget.data.length,
                ),
              ));
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
