import 'package:flutter/material.dart';
import '../bean/ChapterResponse.dart';
import '../weight/SystemItemCard.dart';

class SystemItemOneWidget extends StatelessWidget {
  final List<Chapter> data;

  const SystemItemOneWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return SystemItemCard(data[index]);
      },
    );
  }
}
