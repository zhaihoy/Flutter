import 'package:db/weight/SystemItemCard.dart';
import 'package:flutter/material.dart';

import '../bean/ChapterResponse.dart';
import '../service/ApiService.dart';

class SystemItemOneWidget extends StatefulWidget {
  const SystemItemOneWidget({super.key});

  @override
  State<SystemItemOneWidget> createState() => _SystemItemOneWidgetState();
}

class _SystemItemOneWidgetState extends State<SystemItemOneWidget> {
  List<Chapter> data = [];

  @override
  Widget build(BuildContext context) {
    print("zhy^_^ " + data.length.toString());
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SystemItemCard();
        });
  }

  @override
  void initState() {
    super.initState();
    _fetchItemData();
  }

  Future<void> _fetchItemData() async {
    var fetchPageSysItemData = await ApiService().fetchPageSysItemData();
    data.clear();
    data.addAll(fetchPageSysItemData.data);
  }
}
