import 'dart:convert';
import 'package:http/http.dart' as http;

import '../bean/BannerBean.dart';
import '../bean/ResponseData.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

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
        //在Flutter中，你可以使用Map<String, dynamic>来接收和解析JSON数据。
        // 实际上，Dart的dart:convert库中的json.decode函数会将JSON数据解析为一个包含嵌套Map和List的结构。
        // 然后，你可以使用这些Map和List来进一步处理和访问数据。
        final jsonResponse = json.decode(body) as Map<String, dynamic>;
        return ResponseData.fromJson(jsonResponse);
      } else {
        throw Exception('Error: $statusCode, Body: $body');
      }
    } else {
      throw Exception('Error: $statusCode, Body: $body');
    }
  }
}
