Flutter 面试通常涉及以下几个主要知识点：

1. **Flutter 基础知识**：
   - Flutter 是什么？它是一个开源的跨平台移动应用开发框架，由谷歌推出，使用 Dart 语言进行开发。
   - Flutter 的特点：热重载、丰富的组件库、高性能等。

2. **Dart 语言**：
   - Dart 语言的基本语法：变量、函数、类、继承、接口等。
   - 异步编程：Future、async、await 等关键字的使用。

3. **Widget**：
   - Flutter 应用程序的 UI 是通过组合 Widget 构建而成的。
   - Widget 分为 StatelessWidget 和 StatefulWidget 两种。
   - 常见的布局 Widget，如 Container、Column、Row、Stack 等。
   - 常见的功能性 Widget，如 Text、Image、ListView、GridView 等。

4. **State Management（状态管理）**：
   - 状态管理在 Flutter 中非常重要，常用的方案包括 setState、Provider、Bloc、GetX 等。
   - 状态管理的选择取决于应用的规模和复杂性。

5. **网络请求**：
   - 在 Flutter 中进行网络请求的常用库：如 Dio、http 等。
   - 异步处理和数据解析。

6. **路由管理**：
   - 如何进行页面之间的导航管理，包括命名路由和参数传递。

7. **Flutter 生态系统**：
   - 熟悉常用的第三方库和组件，如 Flutter 社区提供的开源库、插件等。
   - 对 Flutter 的生态有一定的了解和实际使用经验。

8. **性能优化**：
   - 理解 Flutter 应用的性能优化策略，如减少 Widget 的重建、避免不必要的重绘等。

9. **测试**：
   - 单元测试和集成测试在 Flutter 中的实施方法和工具。

10. **版本管理和发布**：
   - Flutter 应用程序的版本管理和发布流程。

#### 开发日记

1. **Note 页面绘制效率**
   主页切换tab 为了防止重复的刷新布局 我们使用 BottomNavigationBarProvider
   ```
   class BottomNavigationBarProvider extends ChangeNotifier {

    int _selectedIndex = 0;

    int get selectedIndex => _selectedIndex;

    void updateIndex(int index) {
    if (index != _selectedIndex) {
    _selectedIndex = index;
     notifyListeners();
      }
     }
   }
    ```
- 底部导航栏状态管理：

  使用 BottomNavigationBarProvider 类来管理底部导航栏的状态，包括当前选中的索引和 PageController 实例。
  在 HomePage 中通过 ChangeNotifierProvider 提供 BottomNavigationBarProvider 实例，并在需要监听状态变化的地方使用
  Consumer 包裹。

- 页面切换的优化：

  在 PageView 的 onPageChanged 回调中更新 BottomNavigationBarProvider的状态，确保页面切换时底部导航栏和顶部标题栏同步更新。
  在底部导航栏的 onTap 回调中调用 Provider 更新状态，并使用 PageController 控制页面切换，确保用户切换页面时的体验流畅。
  关于页面重建的问题，涉及到的主要是 PageView 组件。在 Flutter 中，PageView
  的子页面在切换时是会重新加载的，这是其设计上的特性。因此，无论是否使用了状态管理，页面切换都会导致当前页面的
  build 方法被调用。

  在您的代码中，使用 Consumer<BottomNavigationBarProvider>
  只是在状态变化时更新了底部导航栏和顶部标题栏的显示内容，而不会导致整个页面重新构建。但是，PageView
  子页面在切换时仍然会重新加载，这与底部导航栏的状态管理并没有直接关系。

  如果您希望避免页面重新加载带来的性能损耗，可以考虑使用 AutomaticKeepAliveClientMixin 或
  IndexedStack 来保持页面的状态，而不是每次切换都重新加载内容。这样可以确保在用户切换页面时保持页面的状态，提升用户体验。

综上所述，底部导航栏的状态管理并不会直接影响页面切换时 PageView 子页面的重新加载，这是 PageView 的默认行为。

- 流程是这样

  ```
  page 中  consumer <Provider> 监听 Provider的变化 当Provider notifychange时 监听变化 consumer 将会收到通知
  page 中 consumer 将会更新 
  开发  中 consumer 包裹的单元越小 绘制的效率越高 也就是说这是提高页面绘制的一种手段
  ```

2. **页面绘制 ☞ 页面状态管理 （with AutomaticKeepAliveClientMixin）**

**AutomaticKeepAliveClientMixin** 是 Flutter 中的一个 Mixin 类，用于在组件重建时保持组件的状态。在 Flutter 中，当组件树重建时，如果不是 StatefulWidget（是StatefulWidget但是在ViewPage中） 或者它们的 State 对象没有继承 AutomaticKeepAlive ，那么组件的状态会丢失。

为了解决这个问题，可以使用 AutomaticKeepAliveClientMixin。它提供了一种机制，允许组件通知 Flutter 框架即使在重建时也应该保持它们的状态。具体使用方法如下：

使用 Mixin: 要使用 AutomaticKeepAliveClientMixin，需要将你的 StatefulWidget 的 State 类与它混合（with）使用。

```
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 返回 true 来告诉 Flutter 保持状态不被重置

  @override
  Widget build(BuildContext context) {
    super.build(context); // 确保调用 super.build(context) 来连接 Mixin
    return Container(
      // 这里是你的组件 UI
    );
  }
}

```
这个 Mixin 特别适用于那些需要在重建时保持其内部状态（比如列表中的滚动位置）的部分 UI，但是这些部分是封装在无状态组件中或者无法自行管理状态保持的情况。它有助于提高性能和用户体验，避免不必要地重置组件状态。

