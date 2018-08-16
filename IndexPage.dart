import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/index/IndexPageBannerBean.dart';
import 'package:flutter_app/utils/BannerView.dart';

class IndexPage extends StatefulWidget {
  @override
  createState() => new IndexPageState();
}

class IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  List<BannerChildBean> mResult = [];
  String bannerTitle = "ssss";

  @override
  bool get wantKeepAlive => true;

  _getIPAddress() async {
    var url = 'http://www.wanandroid.com/banner/json';
    var httpClient = new HttpClient();

    List<BannerChildBean> result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        result = new IndexPageBannerBean.fromJson(JSON.decode(json)).data;
      } else {
        result = null;
      }
      request.close();
    } catch (exception) {
      result = null;
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      mResult = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _getIPAddress();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              BannerView(
                data: mResult == null ? [] : mResult,
                onPageChanged: onPageChanged,
                buildShowView: (index, itemData) {
                  return new FadeInImage(
                      placeholder: ExactAssetImage("images/image.png"),
                      image: NetworkImage(mResult[index].imagePath));
                },
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                decoration: BoxDecoration(color: Colors.black38),
                child: Text(
                  bannerTitle,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      print(index);
      if (mResult != null && mResult.length > index) {
        this.bannerTitle = mResult[index].title;
      }
    });
  }
}
