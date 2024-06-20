import 'package:flutter/material.dart';

class SystemItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // 替换为实际颜色
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2), // 替换为实际角半径
      ),
      elevation: 1, // 替换为实际的阴影高度
      child: InkWell(
        onTap: () {
          // 添加点击事件
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0), // 替换为实际的内边距
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Name', // 替换为实际文本
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary, // 替换为实际颜色
                      fontSize: 16, // 替换为实际字体大小
                    ),
                  ),
                  SizedBox(height: 10), // 替换为实际的间距
                  Text(
                    'Android Studio相关   gradle  官方发布', // 替换为实际文本
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary, // 替换为实际颜色
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward, // 替换为实际图标
                size: 24, // 替换为实际尺寸
              ),
            ],
          ),
        ),
      ),
    );
  }
}
