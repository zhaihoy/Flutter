import 'dart:convert';

import 'package:db/bean/PageResponseData.dart';
import 'package:http/http.dart' as http;

import '../bean/Article.dart';
import '../bean/ArticleResponse.dart';
import '../bean/ChapterResponse.dart';
import '../bean/ResponseData.dart';
import 'ApiConstants.dart';

class ApiService {
  final String baseUrl;
  static final ApiService _instance =
      ApiService._internal(ApiConstants.baseUrl);

  // 私有构造函数
  ApiService._internal(this.baseUrl);

  // 工厂构造函数返回同一个实例
  factory ApiService() {
    return _instance;
  }

  // GET 请求
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return _processResponse(response);
  }

  // POST 请求
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  // 处理响应
  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(body);
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  //在Dart语言中，dynamic是一种特殊的类型标注，具有以下几个重要的特性和意义：
  //
  // 动态类型：dynamic类型表示一个可以包含任意类型值的变量。在Dart中，所有的对象都是动态的，这意味着你可以将任何类型的值赋给dynamic类型的变量，而不会触发编译时类型检查。
  //
  // 运行时类型检查：尽管dynamic类型可以接受任何类型的值，但是在运行时会进行类型检查以确保操作的安全性。如果你尝试对一个dynamic类型的变量进行不合适的操作（比如将一个数字加到一个字符串上），会在运行时抛出类型异常。
  //
  // 灵活性：dynamic类型在某些情况下非常有用，特别是当你处理各种不同类型的数据或者在某些框架（比如Flutter）中需要动态解析和操作JSON数据时。它允许你编写更为灵活和通用的代码，但同时也需要更多的注意力来确保类型安全。
  //
  // 与静态类型的区别：与之相对应的是静态类型（比如int, String, List等），静态类型在编译时会进行类型检查，因此在编写和阅读代码时更容易理解和预测程序的行为。静态类型有助于捕获一些常见的错误，但也可能会限制代码的灵活性。
  Future<ResponseData> fetchImages(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ResponseData.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  // https://www.wanandroid.com/article/list/{0}/json
  //
  // 方法：GET
  // 参数：页码，拼接在连接中，从0开始。

  Future<PagePageResponseData> fetchPagedData(int page) async {
    final response =
        await http.get(Uri.parse('$baseUrl${"article/list/"}$page/json'));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return PagePageResponseData.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  Future<PagePageResponseData> fetchPageTopData() async {
    final response = await http.get(Uri.parse("${baseUrl}article/top/json"));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return PagePageResponseData.fromTopJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  /// 请求公众号列表
  Future<ChapterResponse> fetchPagePublicNumberItemData() async {
    final response = await http
        .get(Uri.parse(baseUrl + ApiConstants.WXARTICLE_CHAPTERS_LIST));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ChapterResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  String getWxArticleUrl(int id, int page) {
    // 使用字符串插值来动态替换参数
    return baseUrl +
        ApiConstants.WXARTICLE_LIST
            .replaceAll('{id}', id.toString())
            .replaceAll('{page}', page.toString());
  }

  ///公众号文章列表
  Future<ArticleResponse> fetchArticleResponse(
      int idValue, int pageValue) async {
    var wxArticleUrl = getWxArticleUrl(idValue, pageValue);
    var response = await http.get(Uri.parse(wxArticleUrl));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ArticleResponse.fromJson(jsonResponse);
      } else {
        throw Exception('zhy Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('zhy Error: $statusCode, Body: $body');
    }
  }

  /// cid 查看该目录下所有文章时有用
  /// page 页码
  String getArticleUrl(int cid, int page) {
    // 使用字符串插值来动态替换参数
    return baseUrl +
        ApiConstants.SYS_DEATIL_LIST
            .replaceAll('{cid}', cid.toString())
            .replaceAll('{page}', page.toString());
  }

  /// page 页码
  String getSQAUrl(int page) {
    // 使用字符串插值来动态替换参数
    return baseUrl +
        ApiConstants.SQA_LIST.replaceAll('{page}', page.toString());
  }

  /// 请求体系列表
  Future<ChapterResponse> fetchPageSysItemData() async {
    final response = await http.get(Uri.parse(baseUrl + ApiConstants.SYS_LIST));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ChapterResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  ///体系文章列表
  Future<ArticleResponse> fetchSysResponse(int idValue, int pageValue) async {
    var wxArticleUrl = getArticleUrl(idValue, pageValue);
    var response = await http.get(Uri.parse(wxArticleUrl));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ArticleResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  Future<SysResponseData> fetchPagedNavigation() async {
    final response =
        await http.get(Uri.parse(baseUrl + ApiConstants.SYS_NAVI_LIST));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return SysResponseData.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }

  ///广场列表数据
  /// https://wanandroid.com/user_article/list/页码/json
  /// GET请求
  /// 页码拼接在url上从0开始
  /// 注：该接口支持传入 page_size 控制分页数量，取值为[1-40]，不传则使用默认值，一旦传入了 page_size，后续该接口分页都需要带上，否则会造成分页读取错误。
  Future<ArticleResponse> fetchSQAResponse(int pageValue) async {
    var wxArticleUrl = getSQAUrl(pageValue);
    var response = await http.get(Uri.parse(wxArticleUrl));
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ArticleResponse.fromJson(jsonResponse);
      } else {
        throw Exception('zhy Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('zhy Error: $statusCode, Body: $body');
    }
  }

  /// 请求项目列表
  Future<ChapterResponse> fetchPageProjectItemData() async {
    final response = await http.get(Uri.parse(baseUrl + ApiConstants.PROJECT_LIST));
    print("zhy >>"+baseUrl + ApiConstants.PROJECT_LIST);
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ChapterResponse.fromJson(jsonResponse);
      } else {
        throw Exception('zhy Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('zhy Error: $statusCode, Body: $body');
    }
  }

  /// 获取项目item下的列表
  /// 参数：页码，拼接在连接中，从0开始。
  Future<PagePageResponseData> fetchData(int page, int cid) async {
    final response = await http
        .get(Uri.parse('$baseUrl${"project/list/"}$page/json?cid=$cid'));
    print('$baseUrl${"project/list/"}$page/json?cid=$cid'"zhy");
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isNotEmpty) {
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return PagePageResponseData.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }
}
