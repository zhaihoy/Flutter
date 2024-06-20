import 'package:db/page/SystemItemOneWidget.dart';
import 'package:db/service/ApiService.dart';
import 'package:flutter/material.dart';

class SystemPageItem extends StatefulWidget {
  const SystemPageItem({super.key});

  @override
  State<SystemPageItem> createState() => _PageItemState();
}

class _PageItemState extends State<SystemPageItem> {
  var scrollController;
  List<Widget> title = [
    const Tab(
      child: Text(
        "体系",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Tab(
      child: Text("导航", style: TextStyle(color: Colors.white)),
    )
  ];
  List<Widget> pageList = [SystemItemOneWidget(),SystemItemOneWidget()];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: title.length, // 设置 Tab 的数量
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.blue[100], // 设置背景颜色以区分
              child: TabBar(
                tabs: title,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.blue[100],
                labelStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
             Expanded(
              child: TabBarView(
                children:pageList
              ),
            ),
          ],
        ),
      ),
    );
  }
}
