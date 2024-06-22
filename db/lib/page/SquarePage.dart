import 'package:flutter/material.dart';
import 'package:db/bean/PageResponseData.dart';
import 'package:db/service/ApiService.dart';
import '../weight/ArticleCard.dart';

class SquarePageItem extends StatefulWidget {
  SquarePageItem({Key? key}) : super(key: key);

  @override
  State<SquarePageItem> createState() => _SquarePageItemState();
}

class _SquarePageItemState extends State<SquarePageItem>
    with AutomaticKeepAliveClientMixin {
  var currentPage = 0;
  List<Article> data = [];
  var scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _fetchData(false); // Initial data fetch
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData(bool isLoadMore) async {
    if (isLoading) return; // Prevent multiple requests
    setState(() {
      isLoading = true;
    });

    try {
      var articleResponse = await ApiService().fetchSQAResponse(currentPage);
      var newData = articleResponse.data.datas;

      setState(() {
        if (!isLoadMore) {
          data.clear(); // Clear data if it's a refresh action
        }
        data.addAll(newData);
        currentPage++;
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    await _fetchData(false);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (isLoading) return; // Prevent multiple requests
    _fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        controller: scrollController,
        itemCount: data.length + 1, // +1 for progress indicator at the end
        itemBuilder: (context, index) {
          if (index < data.length) {
            return ArticleCard(data[index]);
          } else {
            return _buildProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
