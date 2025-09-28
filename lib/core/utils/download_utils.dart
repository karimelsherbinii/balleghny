import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DownloadUtils {
  static const platform = MethodChannel('utrujja/downloadPath');

  static Future<String?> getDownloadPath() async {
    try {
      print("Future<String?> getDownloadPath() ");
      String downloadPath = (await platform.invokeMethod("getDownloadPath"));
      print("Future<String?> getDownloadPath() : done");
      print("Future<String?> getDownloadPath() : $downloadPath");

      return downloadPath;
    } on PlatformException catch (exception) {
      debugPrint(exception.toString());
    }
    return null;
  }
}
