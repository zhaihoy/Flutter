import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../bean/Article.dart';
import '../weight/SysItemTwoRightItem.dart';

class SystemItemTwoWidget extends StatefulWidget {
  final List<Chapter> data;

  SystemItemTwoWidget(this.data, {Key? key}) : super(key: key);

  @override
  State<SystemItemTwoWidget> createState() => _SystemItemTwoWidgetState();
}

class _SystemItemTwoWidgetState extends State<SystemItemTwoWidget> {
  late ScrollController scrollController;
  late ScrollController scrollController2;
  double proportion = 1.0;
  int _selectedIndex = 0; // State variable to keep track of the selected index
  List<Widget> rightPage = [];
  List<double> rightPageHeights =
  []; // List to store heights of rightPage items

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController2 = ScrollController();
    scrollController2.addListener(_scrollListener);

    // Initialize rightPage using List.generate
    rightPage = List.generate(
        widget.data.length,
            (index) =>
            StsItemTwoRightItem(
              widget.data[index].articles,
              onHeightChanged: (double height) {
                rightPageHeights[index] = height;
              },
            ));
    rightPageHeights = List<double>.filled(widget.data.length, 0.0);
    proportion = widget.data.length / 100;
  }

  @override
  void dispose() {
    scrollController2.removeListener(_scrollListener);
    scrollController.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // 获取当前滚动位置的信息
    final pos = scrollController2.position;
    // Check if the scroll is due to user interaction or programmatic control
    if (pos.userScrollDirection == ScrollDirection.forward ||
        pos.userScrollDirection == ScrollDirection.reverse) {
      double position = pos.pixels;
      double maxScrollExtent = pos.maxScrollExtent;
      double scrollPercentage =
      (position / maxScrollExtent * 100).clamp(0.0, 100.0);
      int index = (proportion * scrollPercentage).floor();
      if (_selectedIndex != index) {
        setState(() {
          _selectedIndex = index;
        });
        _scrollToPosition(index);
      }
    } else {

    }
  }

  void _scrollToPosition(int position) {
    scrollController.animateTo(
      position * 50.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void listen(int index) {
    var currentHeight = 0;
    for (int i = 0; i <= index; i++) {
      currentHeight += rightPageHeights[i].toInt();
    }
    scrollController2.jumpTo(currentHeight * 1.0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    return Row(
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.3,
          child: ListView.builder(
            controller: scrollController,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 50,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    _scrollToPosition(index);
                    listen(_selectedIndex);
                  },
                  child: Chip(
                    key: ValueKey(widget.data[index]),
                    // Example of adding a key
                    label: Text(
                      widget.data[index].name,
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    backgroundColor: _selectedIndex == index
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
            child: ListView(
              controller: scrollController2,
              children: rightPage,
            )),
      ],
    );
  }
}
