import 'dart:convert';
import 'dart:io';
import 'dart:async';

///先判断有本地文件且上次存储距离本次存储超过五分钟 超过五分访问网络 没有的话继续使用本地文件
class FileUtils {
  static const String fileName = 'data.json';

  static Future<File?> saveJsonToFile(
      String fileName, Map<String, dynamic> jsonMap) async {
    try {
      String jsonString = json.encode(jsonMap);
      File file = File(fileName);
      return file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving file: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> readJsonFromFile( String fileName) async {
    try {
      File file = File(fileName);
      if (await file.exists()) {
        // Check file modification time
        DateTime lastModified = await file.lastModified();
        DateTime now = DateTime.now();
        Duration difference = now.difference(lastModified);

        // If file was modified more than 5 minutes ago, return null to force network fetch
        if (difference.inMinutes > 5) {
          return null;
        }

        String jsonString = await file.readAsString();
        return json.decode(jsonString);
      }
    } catch (e) {
      print('Error reading file: $e');
    }
    return null;
  }
}

void main() async {
  // Try to read from file first
  Map<String, dynamic>? loadedJson = await FileUtils.readJsonFromFile("fileName.json");

  if (loadedJson != null) {
    // Use local data
    print('Using local data:');
    print(loadedJson);
  } else {
    // Fetch data from network (simulate fetching from network)
    print('Fetching data from network...');

    // Simulate network delay
    await Future.delayed(Duration(seconds: 3));

    // Example network response
    Map<String, dynamic> jsonMap = {
      'data': [
        {
          "desc": "我们支持订阅啦~",
          "id": 30,
          "imagePath":
              "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
          "isVisible": 1,
          "order": 2,
          "title": "我们支持订阅啦~",
          "type": 0,
          "url": "https://www.wanandroid.com/blog/show/3352"
        },
        {
          "desc": "",
          "id": 6,
          "imagePath":
              "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
          "isVisible": 1,
          "order": 1,
          "title": "我们新增了一个常用导航Tab~",
          "type": 1,
          "url": "https://www.wanandroid.com/navi"
        },
        {
          "desc": "一起来做个App吧",
          "id": 10,
          "imagePath":
              "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
          "isVisible": 1,
          "order": 1,
          "title": "一起来做个App吧",
          "type": 1,
          "url": "https://www.wanandroid.com/blog/show/2"
        }
      ],
      "errorCode": 0,
      "errorMsg": ""
    };

    // Save fetched data to file
    await FileUtils.saveJsonToFile("fileName.json",jsonMap);

    // Use fetched data
    print('Using fetched data:');
    print(jsonMap);
  }
}
