import 'package:db/widget/BannerWidget.dart';
import 'package:flutter/material.dart';

class homePageItem extends StatefulWidget {
  const homePageItem({super.key});

  @override
  State<homePageItem> createState() => _homePageItemState();
}

class _homePageItemState extends State<homePageItem> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BannerWidget(),
    );
  }
}
