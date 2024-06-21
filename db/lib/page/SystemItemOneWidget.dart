import 'package:flutter/material.dart';
import '../bean/ChapterResponse.dart';
import '../service/ApiService.dart';
import '../weight/SystemItemCard.dart';

class SystemItemOneWidget extends StatefulWidget {
  List<Chapter> data;

  SystemItemOneWidget(this.data, {super.key});

  @override
  State<SystemItemOneWidget> createState() => _SystemItemOneWidgetState();
}

class _SystemItemOneWidgetState extends State<SystemItemOneWidget> {
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    // _fetchItemData();
  }
  //
  // Future<void> _fetchItemData() async {
  //   if (widget.data.isEmpty) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return Center(child: CircularProgressIndicator());
    // }
    //
    // if (hasError) {
    //   return Center(child: Text('Error loading data.'));
    // }

    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return SystemItemCard(widget.data[index]);
        // return Text(data[index]);
      },
    );
  }
}
