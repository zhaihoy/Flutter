import 'package:flutter/material.dart';

class SystemPageItem extends StatefulWidget {
  const SystemPageItem({super.key});

  @override
  State<SystemPageItem> createState() => _PageItemState();
}

class _PageItemState extends State<SystemPageItem> {
  @override
  Widget build(BuildContext context) {
    return Text("SystemPageItem");
  }
}
