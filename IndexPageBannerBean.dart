import 'dart:convert' show json;


class IndexPageBannerBean {

  int errorCode;
  String errorMsg;
  List<BannerChildBean> data;


  IndexPageBannerBean.fromParams({this.errorCode, this.errorMsg, this.data});

  factory IndexPageBannerBean(jsonStr) => jsonStr is String ? IndexPageBannerBean.fromJson(json.decode(jsonStr)) : IndexPageBannerBean.fromJson(jsonStr);

  IndexPageBannerBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = [];

    for (var dataItem in jsonRes['data']){

      data.add(new BannerChildBean.fromJson(dataItem));
    }


  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}



class BannerChildBean {

  int id;
  int isVisible;
  int order;
  int type;
  String desc;
  String imagePath;
  String title;
  String url;


  BannerChildBean.fromParams({this.id, this.isVisible, this.order, this.type, this.desc, this.imagePath, this.title, this.url});

  BannerChildBean.fromJson(jsonRes) {
    id = jsonRes['id'];
    isVisible = jsonRes['isVisible'];
    order = jsonRes['order'];
    type = jsonRes['type'];
    desc = jsonRes['desc'];
    imagePath = jsonRes['imagePath'];
    title = jsonRes['title'];
    url = jsonRes['url'];

  }

  @override
  String toString() {
    return '{"id": $id,"isVisible": $isVisible,"order": $order,"type": $type,"desc": ${desc != null?'${json.encode(desc)}':'null'},"imagePath": ${imagePath != null?'${json.encode(imagePath)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

