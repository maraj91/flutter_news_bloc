import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static Future<void> launchURL(String url) async {
    if(!await launchUrl(Uri.parse(url))){
      if (kDebugMode) {
        print("Could not load $url");
      }
    }
  }
}