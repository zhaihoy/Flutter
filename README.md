# Flutter Project

## 项目简介

这是一个基于 Flutter 的项目，包含了多个页面、组件以及数据处理类。项目主要功能包括展示文章、系统页面、项目页面、公共页面以及主页等。项目使用 Fluro 进行路由管理。

## 目录结构

```
ib/
├── bean/
│ ├── ResponseData.dart
│ ├── PageResponseData.dart
│ ├── ChapterResponse.dart
│ ├── BannerBean.dart
│ └── ArticleResponse.dart
├── page/
│ ├── WebViewPage.dart
│ ├── SystemPagetem.dart
│ ├── SystemItemOneWidget.dart
│ ├── SquarePagetem.dart
│ ├── PublicNumberItem.dart
│ ├── PublicCommonWiget.dart
│ ├── ProjectPageItem.dart
│ ├── NotPage.dart
│ ├── homePageItem.dart
│ └── HomePage.dart
├── widget/
│ ├── ArticleCard.dart
│ ├── DrawContainer.dart
│ ├── PagePublicWidget.dart
│ ├── splashWeight.dart
│ ├── SystemItemCard.dart
│ └── TagWidget.dart
└── utils/
└── Fluroutils.dart
```

使用说明

路由跳转
项目使用 Fluro 进行路由管理。Fluroutils 类提供了三个主要的方法用于路由跳转和返回。

跳转到指定页面
```
import 'package:flutter/cupertino.dart';
import 'package:your_project/utils/Fluroutils.dart';

Fluroutils.navigateTo(context, "/path/to/page", arguments: {"key": "value"});

```
跳转并获取结果
```

Fluroutils.navigateToResult(context, "/path/to/page", (result) {
  // Handle result
}, arguments: {"key": "value"});
```
示例代码
跳转到 WebView 页面
```
import 'package:flutter/material.dart';
import 'package:your_project/utils/Fluroutils.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Fluroutils.navigateTo(context, "/webview", arguments: {"url": "https://www.example.com"});
          },
          child: Text("Go to WebView"),
        ),
      ),
    );
  }
}

```

### 本项目暂时未开发完成 （请切分支）...
