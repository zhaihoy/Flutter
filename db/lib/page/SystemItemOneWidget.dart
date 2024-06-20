import 'package:flutter/material.dart';
import '../bean/ChapterResponse.dart';
import '../service/ApiService.dart';
import '../weight/SystemItemCard.dart';

class SystemItemOneWidget extends StatefulWidget {
  const SystemItemOneWidget({super.key});

  @override
  State<SystemItemOneWidget> createState() => _SystemItemOneWidgetState();
}

class _SystemItemOneWidgetState extends State<SystemItemOneWidget> {
  List<Chapter> data = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchItemData();
  }

  Future<void> _fetchItemData() async {
    try {
      var fetchPageSysItemData = await ApiService().fetchPageSysItemData();
      debugPrint("Data length: ${fetchPageSysItemData.data.length}");
      setState(() {
        data.clear();
        data.addAll(fetchPageSysItemData.data);
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(child: Text('Error loading data.'));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return SystemItemCard(data[index]);
        // return Text(data[index]);
      },
    );
  }
}
