import 'package:db/bean/PageResponseData.dart';
import 'package:db/utils/FluroUtils.dart';
import 'package:db/weight/TagWidget.dart';
import 'package:db/weight/route/ARoute.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 主页Item组件
class ArticleCard extends StatefulWidget {
  final Article data;
  final from = false;

  const ArticleCard(this.data, {super.key});

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  List<Widget> tagWidget = [];

  @override
  void initState() {
    super.initState();
    var tags = widget.data.tags;
    if (tags.isNotEmpty) {
      for (var t in tags) {
        tagWidget.add(TagWidget(t));
      }
    } else {
      var tag = Tag(name: "广场Tab/广场", url: "");
      tagWidget.add(TagWidget(tag));
    }
  }

  /// InkWell 组件是 Flutter 中的一个可点击组件，通常用于包裹其它组件以提供点击响应效果。它的外观效果会对触摸作出反馈，比如水波纹效果或者自定义的点击效果。

  /// 主要特点包括：

  /// 点击效果：InkWell 提供了一个点击效果，用户点击组件时会产生类似水波纹的动画效果（如果未进行其他自定义效果）。

  /// 包裹其它组件：您可以将 InkWell 包裹在任何需要响应点击事件的组件外部，比如 Text、Image 等。

  @override
  Widget build(BuildContext context) => Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: InkWell(
          onTap: () {
            Fluroutils.navigateTo(context,
                '${ARoute.webViewPage}?title=${Uri.encodeComponent(widget.data.title)}&url=${Uri.encodeComponent(widget.data.link)}');
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(width: double.infinity, height: 10),
                _buildTitle(),
                _buildFooter()
              ],
            ),
          ),
        ),
      );

  Widget _buildHeader() {
    //todo 要注意横线宽度超出屏幕  设置singleScrollView也是不行的 因为跟我们设计理念不一致
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.data.isTop) _buildTag('顶置', Colors.red),
        // if (widget.data.chapterName.isNotEmpty)
        //   _buildTag(widget.data.chapterName, Colors.red),
        if (widget.data.superChapterName.isNotEmpty &&
            widget.data.superChapterName != "广场Tab")
          _buildTag(widget.data.superChapterName, Colors.blueAccent)
        else if (widget.data.shareUser.isNotEmpty)
          _buildTag(widget.data.shareUser, Colors.blueAccent)
        else if (widget.data.chapterName.isNotEmpty)
          _buildTag(widget.data.chapterName, Colors.blueAccent),
        const SizedBox(width: 8.0),
        if (widget.data.author.isNotEmpty) _buildAuthor(),
        const SizedBox(width: 8.0),
        if (widget.data.niceDate.isNotEmpty) _buildDate(),
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      margin: const EdgeInsets.only(left: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10.0,
        ),
      ),
    );
  }

  Widget _buildAuthor() {
    return Text(
      widget.data.author,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12.0,
      ),
    );
  }

  Widget _buildDate() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8.0),
            Text(
              widget.data.niceDate.toString(),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            widget.data.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: tagWidget,
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            Fluttertoast.showToast(
                msg: "哎呀 你点痛我了~",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[200],
                textColor: Colors.white,
                fontSize: 16.0
            );
          },
        ),
      ],
    );
  }
}
