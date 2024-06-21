import 'package:db/page/SystemItemOneWidget.dart';
import 'package:db/service/ApiService.dart';
import 'package:flutter/material.dart';

class SystemPageItem extends StatefulWidget {
  const SystemPageItem({super.key});

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
  List<Widget> pageList = [];

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _fetchItemData();
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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : hasError
                      ? Center(child: Text('Error loading data.'))
                      : TabBarView(children: pageList),
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
        pageList = [
          SystemItemOneWidget(fetchPageSysItemData.data),
          SystemItemOneWidget(fetchPageSysItemData.data),
        ];
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }
}
