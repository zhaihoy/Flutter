import 'package:db/bean/PageResponseData.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  Tag t;

  TagWidget(this.t, {super.key});

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      // 调整左右间距
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 10), // 设置按钮最小宽度为0，以适应内容
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 5), // 调整左右间距
          ),
          child: Text(
            widget.t.name,
            style: const TextStyle(fontSize: 12, color: Color(0xB3424242)),
          ),
        ),
      ),
    );
  }
}
