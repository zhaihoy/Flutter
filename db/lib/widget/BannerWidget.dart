import 'package:carousel_slider/carousel_slider.dart';
import 'package:db/bean/BannerBean.dart';
import 'package:db/service/ApiConstants.dart';
import 'package:flutter/material.dart';

import '../bean/ResponseData.dart';
import '../service/ApiService.dart';
import 'DetailPage.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final ApiService apiService = ApiService(baseUrl: ApiConstants.baseUrl);
  late Future<ResponseData> responseData;

  @override
  void initState() {
    super.initState();
    responseData = apiService.fetchImages(ApiConstants.BANNER);
  }

  /**
   *
   * 一 、FutureBuilderWidget类:
      fetchData 方法：模拟一个网络请求，返回一个包含字符串数据的 Future。
      在 build 方法中使用 FutureBuilder：
      future: 传入 fetchData 方法，提供 Future。
      builder: 根据 snapshot 的不同状态返回不同的 widget：
      waiting 状态时显示 CircularProgressIndicator。
      出错时显示错误信息。
      成功时显示获取的数据。
      FutureBuilder 非常适合用来处理异步数据，在数据未加载完成之前显示加载状态，加载完成后显示数据，出错时显示错误信息。这样可以使你的 Flutter 应用更加响应式和用户友好。

      二、CarouselSlider 是一个 Flutter 插件，用于创建轮播滑块（Carousel Slider），
      它可以自动轮播一组视图，用户也可以手动滑动视图。这个插件非常适合用于展示一系列图片或广告横幅，
      并提供了丰富的自定义选项，如自动播放、循环播放、页面指示器等。
      CarouselSlider:
      options: 用于配置轮播滑块的各种选项。
      height: 轮播滑块的高度。
      autoPlay: 是否自动播放。
      enlargeCenterPage: 是否放大当前页面。
      aspectRatio: 宽高比。
      autoPlayInterval: 自动播放的间隔时间。
      autoPlayAnimationDuration: 自动播放动画的持续时间。
      autoPlayCurve: 自动播放的动画曲线。
      pauseAutoPlayOnTouch: 是否在触摸时暂停自动播放。
      items: 轮播滑块的项目列表，映射自 imgList。
   */
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseData>(
      future: responseData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data!.errorCode != 0) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
          return const Center(child: Text('No images found'));
        } else {
          return CarouselSlider.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index, realIndex) {
              final bean =snapshot.data!.data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(imageUrl: bean.imagePath),
                    ),
                  );
                },
                child: Image.network(bean.imagePath, fit: BoxFit.cover),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
          );
        }
      },
    );
  }
}
