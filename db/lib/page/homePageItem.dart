import 'dart:async';

import 'package:db/bean/PageResponseData.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/weight/ArticleCard.dart';
import 'package:db/widget/BannerWidget.dart';
import 'package:flutter/material.dart';

class homePageItem extends StatefulWidget {
  const homePageItem({super.key});

  @override
  State<homePageItem> createState() => _homePageItemState();
}

class _homePageItemState extends State<homePageItem> {
  List<Article> items = [];
  int page = 0;
  bool isLoading = false;
  bool reachedEnd = false;
  final ScrollController _scrollController = ScrollController();

  // SliverToBoxAdapter 和 SliverList
  // 都是 Flutter 中用于构建可滚动视图的
  // slivers。
  // slivers 是 CustomScrollView 的一部分，它们定义了滚动视图中的各个部分。
  // SliverToBoxAdapter
  // SliverToBoxAdapter 的作用是将一个普通的 widget 包装成 sliver，使其可以被包含在 CustomScrollView 中
  // 。它通常用于将单个非滚动 widget（如 banner、标题、图片等）插入到滚动视图中。
  //
  // SliverList
  // SliverList 的作用是创建一个滚动的列表。
  // 它类似于 ListView，但可以和其他 sliver 一起使用以创建复杂的滚动效果
  // 。SliverList 通过 SliverChildBuilderDelegate 或
  // SliverChildListDelegate 来定义其子项。通常用于显示大规模的、动态的子项列表。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController, // 将滚动控制器分配给CustomScrollView
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: BannerWidget(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < items.length) {
                    return ArticleCard(items[index]);
                  } else {
                    if (reachedEnd) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: Text('已加载完所有数据')),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF8C9EFF),
                        )),
                      );
                    }
                  }
                },
                // 计算列表项数量，包括加载指示器或已加载完所有数据的文本
                childCount: items.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 释放滚动控制器
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // 添加滚动监听器
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    _refresh();
  }

  Future<void> _refresh() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    try {
      PagePageResponseData responsePopularData =
          await ApiService().fetchPageTopData();
      List<Article> responsePopularDataItems = responsePopularData.data.datas;
      items.clear();
      items.addAll(responsePopularDataItems);
      // 1. 调用 ApiService().fetchPagedData(page) 获取数据 刷新一般都是刷第一页数据
      PagePageResponseData responseData = await ApiService().fetchPagedData(0);
      // 2. 解析响应数据
      List<Article> newItems = responseData.data.datas;
      items.addAll(newItems);
      reachedEnd = items.isEmpty;
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
        items;
      });
    }
  }

//上拉加载更多需要配合SliverList  进行监听
  Future<void> _loadMore() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    try {
      // 1. 调用 ApiService().fetchPagedData(page) 获取数据 刷新一般都是刷第一页数据
      page++;
      PagePageResponseData responseData =
          await ApiService().fetchPagedData(page);
      // 2. 解析响应数据
      List<Article> newItems = responseData.data.datas;
      items.addAll(newItems);
      reachedEnd = items.isEmpty;
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
        items;
      });
    }
  }
}
