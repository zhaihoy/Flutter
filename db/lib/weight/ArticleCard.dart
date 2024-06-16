import 'package:flutter/material.dart';

/// 主页Item组件
class ArticleCard extends StatefulWidget {
  const ArticleCard({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ArticleCardState();
  }
}

/**
 *
    InkWell 组件是 Flutter 中的一个可点击组件，通常用于包裹其它组件以提供点击响应效果。它的外观效果会对触摸作出反馈，比如水波纹效果或者自定义的点击效果。

    主要特点包括：

    点击效果：InkWell 提供了一个点击效果，用户点击组件时会产生类似水波纹的动画效果（如果未进行其他自定义效果）。

    包裹其它组件：您可以将 InkWell 包裹在任何需要响应点击事件的组件外部，比如 Text、Image 等。

    触摸反馈：除了点击外，InkWell 也可以响应触摸事件，比如长按或者按下。

    属性：InkWell 可以通过属性来定制其行为和外观，比如 onTap 用于定义点击回调、borderRadius 用于定义边框圆角、highlightColor 用于定义高亮时的颜色等。
 */

class _ArticleCardState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        onTap: () {
// Handle tap event
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    margin: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: const Text(
                      '顶置',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    margin: EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Text(
                      '新鲜',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    margin: EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Text(
                      '标签',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                '作者名字',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '文章发布日期',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/vicinity_drawer_radar_sakura.png',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '文章标题文章标题文章标题文章标题文章标题文章标题文章标题',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '文章分类',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
// Handle like button press
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
