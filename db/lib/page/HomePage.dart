import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../weight/DrawContainer.dart';
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
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectIndex = 0;
  final List<Widget> pageList = <Widget>[
    const homePageItem(),
    const PublicNumberItem(),
    const SystemPageItem(),
    const SquarePageItem(),
    const ProjectPageItem()
  ];
  final List<String> titleNameList = ["首页", "公众号", "体系", "广场", "项目"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer(); // Open drawer
                  },
                ),
                title: const Text('Flutter'),
                floating: true,
                snap: true,
              ),
            ];
          },
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            children: pageList,
          ),
        ),
        drawer: _buildDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          items: _buildNavBarItems(),
          currentIndex: selectIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white, // 选中时的文字颜色
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF90CAF9), // 设置背景颜色
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: selectIndex == 0 ? Colors.white : Colors.grey),
        label: "首页",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.public, color: selectIndex == 1 ? Colors.white : Colors.grey),
        label: "公众号",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_system_daydream, color: selectIndex == 2 ? Colors.white : Colors.grey),
        label: "体系",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.square_rounded, color: selectIndex == 3 ? Colors.white : Colors.grey),
        label: "广场",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.propane_outlined, color: selectIndex == 4 ? Colors.white : Colors.grey),
        label: "项目",
      ),
    ];
  }

  Widget _buildDrawer() {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: DrawContainerHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        index == 0 ? Icons.collections : index == 1 ? Icons.share : index == 2 ? Icons.settings : Icons.login,
                      ),
                      title: Text(index == 0 ? '收藏' : index == 1 ? '分享' : index == 2 ? '系统' : '登录'),
                      subtitle: Text(index == 0 ? '君子藏器于身' : index == 1 ? '达则兼济天下' : index == 2 ? '内省吾身' : '切换角色'),
                    ),
                    if (index < 3) const Divider(),
                  ],
                );
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
