import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/BottomNavigationBarProvider.dart';
import '../weight/DrawContainer.dart';
import 'homePageItem.dart';
import 'ProjectPageItem.dart';
import 'PublicNumberItem.dart';
import 'SquarePagetem.dart';
import 'SystemPagetem.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    return ChangeNotifierProvider(
      create: (_) => BottomNavigationBarProvider(),
      child: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _titleNameList = [
    "首页",
    "公众号",
    "体系",
    "广场",
    "项目"
  ];
  List<Widget> page = [
    homePageItem(),
    PublicNumberItem(),
    SystemPageItem(),
    SquarePageItem(),
    ProjectPageItem(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Consumer<BottomNavigationBarProvider>(
          builder: (context, provider, child) =>
              Text(
                _titleNameList[provider.selectedIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Open drawer
          },
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        controller: _pageController,
        children:page,
      ),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, provider, child) =>
          BottomNavigationBar(
            items: _buildNavBarItems(),
            currentIndex: provider.selectedIndex,
            onTap: (index) {
              provider.updateIndex(index);
              _pageController.jumpToPage(index);
            },
            selectedItemColor: Colors.white,
            // 选中时的文字颜色
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF90CAF9), // 设置背景颜色
          ),
    );
  }

  List<BottomNavigationBarItem> _buildNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home,
            color: Provider
                .of<BottomNavigationBarProvider>(context)
                .selectedIndex ==
                0
                ? Colors.white
                : Colors.black),
        label: "首页",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.public,
            color: Provider
                .of<BottomNavigationBarProvider>(context)
                .selectedIndex ==
                1
                ? Colors.white
                : Colors.black),
        label: "公众号",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_system_daydream,
            color: Provider
                .of<BottomNavigationBarProvider>(context)
                .selectedIndex ==
                2
                ? Colors.white
                : Colors.black),
        label: "体系",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.square_rounded,
            color: Provider
                .of<BottomNavigationBarProvider>(context)
                .selectedIndex ==
                3
                ? Colors.white
                : Colors.black),
        label: "广场",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.propane_outlined,
            color: Provider
                .of<BottomNavigationBarProvider>(context)
                .selectedIndex ==
                4
                ? Colors.white
                : Colors.black),
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
                        index == 0
                            ? Icons.collections
                            : index == 1
                            ? Icons.share
                            : index == 2
                            ? Icons.settings
                            : Icons.login,
                      ),
                      title: Text(index == 0
                          ? '收藏'
                          : index == 1
                          ? '分享'
                          : index == 2
                          ? '系统'
                          : '登录'),
                      subtitle: Text(index == 0
                          ? '君子藏器于身'
                          : index == 1
                          ? '达则兼济天下'
                          : index == 2
                          ? '内省吾身'
                          : '切换角色'),
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
}
