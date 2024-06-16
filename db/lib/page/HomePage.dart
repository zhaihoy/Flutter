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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
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
                // 设置为true，表示滑动到顶部时隐藏标题
                snap: true,
                // 设置为true，表示向下滚动时AppBar会立即展开，向上滚动时立即收缩
                // flexibleSpace: Placeholder(), 有的像是明星详情页的布局 需要用的flexibleSpace
                // 可选的，设置AppBar背景
              )
            ];
          },
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            children: pageList,
          ),
        ),
        drawer: Drawer(
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
        bottomNavigationBar: BottomNavigationBar(
          items: navBar,
          currentIndex: selectIndex,
          onTap: (index) => _pageController.jumpToPage(index),
          selectedItemColor: const Color(0xFFFFF8E1),
          type: BottomNavigationBarType.fixed,
          // 确保类型为 fixed 否则设置了颜色不生效
          backgroundColor: const Color(0xFF90CAF9), // 设置背景颜色
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
