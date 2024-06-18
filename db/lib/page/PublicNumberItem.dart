import 'package:flutter/material.dart';

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
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
