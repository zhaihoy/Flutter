import 'package:db/page/SystemItemOnePage.dart';
import 'package:db/page/SystemItemTwoPage.dart';
import 'package:db/service/ApiService.dart';
import 'package:flutter/material.dart';

class SystemPageItem extends StatefulWidget {
  List<Widget> pageList = [];
  bool isLoading = true;
  bool hasError = false;

  SystemPageItem({super.key});

  @override
  State<SystemPageItem> createState() => _SystemPageItemState();
}

class _SystemPageItemState extends State<SystemPageItem>
    with AutomaticKeepAliveClientMixin {
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
      var fetchPageSysData =  await ApiService().fetchPagedNavigation();
      setState(() {
        widget.pageList = [
          SystemItemOneWidget(fetchPageSysItemData.data),
          SystemItemTwoWidget(fetchPageSysData.data),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
