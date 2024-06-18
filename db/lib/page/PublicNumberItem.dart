import 'package:db/service/ApiService.dart';
import 'package:db/weight/PagePublicWidget.dart';
import 'package:flutter/material.dart';

import '../bean/ChapterResponse.dart';

class PublicNumberItem extends StatefulWidget {
  const PublicNumberItem({super.key});

  @override
  State<PublicNumberItem> createState() => _PageItemState();
}

class _PageItemState extends State<PublicNumberItem>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Tab> _tab;
  late List<Widget> _children;

  @override
  void initState() async {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    ChapterResponse fetchPagePublicNumberItemData =
        await ApiService().fetchPagePublicNumberItemData();
    _tab.clear();
    for (int i = 0; i < fetchPagePublicNumberItemData.data.length; i++) {
      _tab.add(Tab(text: fetchPagePublicNumberItemData.data[i].name));
      _children.add(PagePublicWidget( fetchPagePublicNumberItemData.data[i]));
    }
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: _tab,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _children,
      ),
    );
  }
}
