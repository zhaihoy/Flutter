import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/BottomNavigationBarProvider.dart';
import '../weight/DrawContainer.dart';
import 'homeItemPage.dart';
import 'ProjectItemPage.dart';
import 'PublicItemNumberPage.dart';
import 'SquarePage.dart';
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

  final List<String> _titleNameList = ["首页", "公众号", "体系", "广场", "项目"];
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
          builder: (context, provider, child) => Text(
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
        children: page,
      ),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  ///底部导航栏状态管理：
  ///
  /// 使用 BottomNavigationBarProvider 类来管理底部导航栏的状态，包括当前选中的索引和 PageController 实例。
  ///在 HomePage 中通过 ChangeNotifierProvider 提供 BottomNavigationBarProvider 实例，并在需要监听状态变化的地方使用 Consumer 包裹。
  ///页面切换的优化：
  ///
  ///在 PageView 的 onPageChanged 回调中更新 BottomNavigationBarProvider 的状态，确保页面切换时底部导航栏和顶部标题栏同步更新。
  ///在底部导航栏的 onTap 回调中调用 Provider 更新状态，并使用 PageController 控制页面切换，确保用户切换页面时的体验流畅。
  ///关于页面重建的问题，涉及到的主要是 PageView 组件。在 Flutter 中，PageView 的子页面在切换时是会重新加载的，这是其设计上的特性。因此，无论是否使用了状态管理，页面切换都会导致当前页面的 build 方法被调用。
  ///
  /// 在您的代码中，使用 Consumer<BottomNavigationBarProvider> 只是在状态变化时更新了底部导航栏和顶部标题栏的显示内容，而不会导致整个页面重新构建。但是，PageView 子页面在切换时仍然会重新加载，这与底部导航栏的状态管理并没有直接关系。
  ///
  /// 如果您希望避免页面重新加载带来的性能损耗，可以考虑使用 AutomaticKeepAliveClientMixin 或 IndexedStack 来保持页面的状态，而不是每次切换都重新加载内容。这样可以确保在用户切换页面时保持页面的状态，提升用户体验。
  ///
  ///综上所述，底部导航栏的状态管理并不会直接影响页面切换时 PageView 子页面的重新加载，这是 PageView 的默认行为。
  Widget _buildBottomNavigationBar() {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, provider, child) => BottomNavigationBar(
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
            color: Provider.of<BottomNavigationBarProvider>(context)
                        .selectedIndex ==
                    0
                ? Colors.white
                : Colors.black),
        label: "首页",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.public,
            color: Provider.of<BottomNavigationBarProvider>(context)
                        .selectedIndex ==
                    1
                ? Colors.white
                : Colors.black),
        label: "公众号",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_system_daydream,
            color: Provider.of<BottomNavigationBarProvider>(context)
                        .selectedIndex ==
                    2
                ? Colors.white
                : Colors.black),
        label: "体系",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.square_rounded,
            color: Provider.of<BottomNavigationBarProvider>(context)
                        .selectedIndex ==
                    3
                ? Colors.white
                : Colors.black),
        label: "广场",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.propane_outlined,
            color: Provider.of<BottomNavigationBarProvider>(context)
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
