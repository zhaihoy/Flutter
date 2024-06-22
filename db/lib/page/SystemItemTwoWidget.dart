import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController2 = ScrollController();
    scrollController2.addListener(_scrollListener);

    // Initialize rightPage using List.generate
    rightPage = List.generate(widget.data.length,
        (index) => StsItemTwoRightItem(widget.data[index].articles));

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
    double position = scrollController2.position.pixels;
    double maxScrollExtent = scrollController2.position.maxScrollExtent;
    double scrollPercentage =
        (position / maxScrollExtent * 100).clamp(0.0, 100.0);

    int index = (proportion * scrollPercentage).floor();
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _scrollToPosition(index);
    }
  }

  void _scrollToPosition(int position) {
    scrollController.animateTo(
      position * 50.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void listen(int index) {
    // Iterate through each item to find its size
    var page = rightPage[index] as StsItemTwoRightItem ;

  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
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
