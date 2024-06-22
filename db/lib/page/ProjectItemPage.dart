import 'package:flutter/material.dart';

import '../weight/FullScreenDraggableButton.dart';

class ProjectPageItem extends StatefulWidget {
  const ProjectPageItem({super.key});

  @override
  State<ProjectPageItem> createState() => _PublicNumberItemState();
}

class _PublicNumberItemState extends State<ProjectPageItem> {
  @override
  Widget build(BuildContext context) {
    return RadialMenuButton();
  }
}
