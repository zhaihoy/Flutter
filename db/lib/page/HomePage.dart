import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // 指定选项卡的数量
        child: Scaffold(
          appBar: AppBar(
            title: Text('DefaultTabController 示例'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car), text: '汽车'),
                Tab(icon: Icon(Icons.directions_transit), text: '公交'),
                Tab(icon: Icon(Icons.directions_bike), text: '自行车'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('汽车选项卡内容')),
              Center(child: Text('公交选项卡内容')),
              Center(child: Text('自行车选项卡内容')),
            ],
          ),
        ),
      ),
    );
  }
}
