import 'package:db/widget/BannerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homePageItem extends StatefulWidget {
  const homePageItem({super.key});

  @override
  State<homePageItem> createState() => _homePageItemState();
}

class _homePageItemState extends State<homePageItem> {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: <Widget>[
            const BannerWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                  ); // <- Add a semicolon here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   items = List.generate(60, (index) => 'Item $index');
  }

  Future<void> _refresh() async {
    // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));
    // Generate new items
    setState(() {});
  }
}
