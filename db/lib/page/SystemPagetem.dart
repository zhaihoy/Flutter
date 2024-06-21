import 'package:db/page/SystemItemOneWidget.dart';
import 'package:db/service/ApiService.dart';
import 'package:flutter/material.dart';

class SystemPageItem extends StatefulWidget {
  List<Widget> pageList = [];
  bool isLoading = true;
  bool hasError = false;

  SystemPageItem({super.key}) {
    print("zhy^_^>>> SystemPageItem");
  }

  @override
  State<SystemPageItem> createState() => _SystemPageItemState();
}

class _SystemPageItemState extends State<SystemPageItem> {
  late ScrollController scrollController;
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

  @override
  void initState() {
    ///所谓的重复加载是指的是数据—get from net->
    ///而不是页面的渲染
    super.initState();
    if (widget.pageList.isEmpty) {
      scrollController = ScrollController();
      _fetchItemData();
    } else {
      setState(() {
        widget.pageList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: title.length,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.blue[100],
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
              child: widget.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : widget.hasError
                      ? const Center(child: Text('Error loading data.'))
                      : TabBarView(children: widget.pageList),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchItemData() async {
    try {
      var fetchPageSysItemData = await ApiService().fetchPageSysItemData();
      setState(() {
        widget.pageList = [
          SystemItemOneWidget(fetchPageSysItemData.data),
          SystemItemOneWidget(fetchPageSysItemData.data),
        ];
        widget.isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
      setState(() {
        widget.isLoading = false;
        widget.hasError = true;
      });
    }
  }
}
