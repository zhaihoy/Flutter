import 'package:flutter/material.dart';
import 'homePageItem.dart';
import 'ProjectPageItem.dart';
import 'PublicNumberItem.dart';
import 'SquarePagetem.dart';
import 'SystemPagetem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList = <Widget>[];
  List<ListTile> titleList = <ListTile>[];

  @override
  void initState() {
    super.initState();
    pageList.clear();
    titleList.clear();
    //初始化五个页面 首页、公众号、体系、广场、项目
    pageList.add(const homePageItem());
    pageList.add(const PublicNumberItem());
    pageList.add(const SystemPageItem());
    pageList.add(const SquarePageItem());
    pageList.add(const ProjectPageItem());
    titleList.add(const ListTile(
      leading: Icon(Icons.collections), // 一个用户头像图标作为leading
      title: Text('收藏'),
      subtitle: Text('君子藏器于身'),
    ));
    titleList.add(const ListTile(
      leading: Icon(Icons.share), // 一个用户头像图标作为leading
      title: Text('分享'),
      subtitle: Text('达则兼济天下'),
    ));
    titleList.add(const ListTile(
      leading: Icon(Icons.settings), // 一个用户头像图标作为leading
      title: Text('系统'),
      subtitle: Text('内省吾身'),
    ));
    titleList.add(const ListTile(
      leading: Icon(Icons.collections), // 一个用户头像图标作为leading
      title: Text('登录'),
      subtitle: Text('切换角色'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(color: Colors.blue),
                child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // 设置填充颜色
                          border:
                              Border.all(color: Colors.black, width: 2), // 设置边框
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // 处理登录按钮点击事件
                        },
                        child: const Text(
                          "点击登录",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      titleList[index],
                      if (index < titleList.length - 1) const Divider(),
                    ],
                  );
                },
                childCount: titleList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
