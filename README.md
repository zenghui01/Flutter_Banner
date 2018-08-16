# Flutter_Banner
flutter 轮播控件

本控件为该控件的改版,有兴趣的朋友可以去看
---
https://github.com/zhangruiyu/BannerView

改版地方：
---
原控件：</br>

1.buildShowView 返回的index存在问题 </br>
2.banner 页数存在问题</br>
3.未处理 onpagechange方法(本人因为项目需要这个)</br>
4.其他有兴趣的朋友自己去看吧

改版后还存在的问题:
---
第一次数据加载完成时，不会调用onpagechange方法</br>

改版原因:</br>
1.看改git也3个月前更新过后也没再更新，避免萌新和我这样的小朋友受到困扰故改版</br>

用法:(详细用法请自己查看其他两个类)
---
```java
  BannerView(
        data: mResult == null ? [] : mResult,
        onPageChanged: onPageChanged,
        buildShowView: (index, itemData) {
            return new FadeInImage(
                   placeholder: ExactAssetImage("images/image.png"),
                   image: NetworkImage(mResult[index].imagePath));
              },
            )
```
