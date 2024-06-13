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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectIndex = 0;
  List<Widget> pageList = <Widget>[];
  List<ListTile> titleList = <ListTile>[];
  List<BottomNavigationBarItem> navBar = <BottomNavigationBarItem>[];
  List<String> titleNameList = ["首页", "公众号", "体系", "广场", "项目"];

  @override
  void initState() {
    super.initState();
    navBar.clear();
    navBar.add(
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"));
    navBar.add(
        const BottomNavigationBarItem(icon: Icon(Icons.public), label: "公众号"));
    navBar.add(const BottomNavigationBarItem(
        icon: Icon(Icons.settings_system_daydream), label: "体系"));
    navBar.add(const BottomNavigationBarItem(
        icon: Icon(Icons.square_rounded), label: "广场"));
    navBar.add(const BottomNavigationBarItem(
        icon: Icon(Icons.propane_outlined), label: "项目"));
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
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Open drawer
          },
        ),
      ),
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
      body: pageList[selectIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          items: navBar,
          currentIndex: selectIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFFFFF8E1),
          type: BottomNavigationBarType.fixed,
          // 确保类型为 fixed 否则设置了颜色不生效
          backgroundColor: const Color(0xFF90CAF9), // 设置背景颜色
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
