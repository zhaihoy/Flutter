import 'dart:math';

import 'package:db/bean/Article.dart';
import 'package:flutter/material.dart';

class StsItemTwoRightItem extends StatefulWidget {
  final List<Article> articles;
  final ValueChanged<double> onHeightChanged; // Callback to parent widget

  StsItemTwoRightItem(this.articles, {required this.onHeightChanged, Key? key})
      : super(key: key);

  @override
  _StsItemTwoRightItemState createState() => _StsItemTwoRightItemState();
}

class _StsItemTwoRightItemState extends State<StsItemTwoRightItem> {
  double _height = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get height after build
      _height = context.size?.height ?? 0.0;
      widget.onHeightChanged(_height);
    });
  }

  double getHeight() {
    return _height;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // 每个chip之间的水平间距
      runSpacing: 4.0, // 每行之间的垂直间距
      children: widget.articles.map((child) {
        return Chip(
          label: Text(child.title),
          backgroundColor: _getRandomColor(),
          labelStyle: TextStyle(color: Colors.white),
        );
      }).toList(),
    );
  }

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Red value
      random.nextInt(256), // Green value
      random.nextInt(256), // Blue value
    );
  }
}
