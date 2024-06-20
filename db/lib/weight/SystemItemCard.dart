import 'package:flutter/material.dart';
import '../bean/ChapterResponse.dart';

class SystemItemCard extends StatelessWidget {
  final Chapter data;

  SystemItemCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      elevation: 1,
      child: InkWell(
        onTap: () {
          // 添加点击事件
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width, // 或者其他具体的宽度
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.children.length,
                        itemBuilder: (context, index) {
                          final childName =
                              data.children[index].name ?? "无了";
                          return Chip(
                            label: Text(childName),
                            backgroundColor: Colors.blue,
                            labelStyle: TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
