import 'package:flutter/material.dart';
import '../bean/ChapterResponse.dart';

class SystemItemCard extends StatefulWidget {
  final Chapter data;
  bool _isInitialized = false;

  SystemItemCard(this.data){
  }
  @override
  _SystemItemCardState createState() => _SystemItemCardState();
}

class _SystemItemCardState extends State<SystemItemCard> {
  @override
  void initState() {
    super.initState();
    // Add a post-frame callback to ensure the widget has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget._isInitialized) {
        print("zhy^_^_isInitialized  ");
        widget._isInitialized = true;
      }
    });
  }

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
                      widget.data.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0, // 每个chip之间的水平间距
                      runSpacing: 4.0, // 每行之间的垂直间距
                      children: widget.data.children.map((child) {
                        return Chip(
                          label: Text(child.name),
                          backgroundColor: Colors.blue,
                          labelStyle: TextStyle(color: Colors.white),
                        );
                      }).toList(),
                    ),
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
