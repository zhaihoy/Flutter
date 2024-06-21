import 'package:flutter/material.dart';
import '../bean/ChapterResponse.dart';
import '../weight/SystemItemCard.dart';

class SystemItemTwoWidget extends StatelessWidget {
  final List<Chapter> data;

  const SystemItemTwoWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data available.'));
    }
    return Row(
      children: [
        ListView.builder(
            // itemCount:,
            itemBuilder: (context, index) {
              return InkWell();
            })
      ],
    );
  }
}
