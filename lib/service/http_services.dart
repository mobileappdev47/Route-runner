import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response?> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      }
      return http.get(
        Uri.parse(url),
        headers: header,
      );
    } catch (e) {
    //  showToast(e.toString());
      return null;
    }
  }

  static Future<http.Response?> postApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
        print("Body => $body");
      }
      return http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } catch (e) {
   //   showToast(e.toString());
      return null;
    }
  }

  static Future<http.Response?> deleteApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      }
      return http.delete(
        Uri.parse(url),
        headers: header,
      );
    } catch (e) {
    //  showToast(e.toString());
      return null;
    }
  }

  // static Future<http.Response?> putApi({
  //   required String url,
  //   dynamic body,
  //   Map<String, String>? header,
  // }) async {
  //   try {
  //     if (kDebugMode) {
  //       print("Url => $url");
  //       print("Header => $header");
  //       print("Body => $body");
  //     }
  //     return http.put(
  //       Uri.parse(url),
  //       headers: header,
  //       body: body,
  //     );
  //   } catch (e) {
  //   //  showToast(e.toString());
  //     return null;
  //   }
  // }
  static Future<http.Response?> putApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
        print("Body => $body");
      }

      final jsonBody = jsonEncode(body); // Convert body to JSON

      return http.put(
        Uri.parse(url),
        headers: header,
        body: jsonBody,
      );
    } catch (e) {
      // Handle the error appropriately
      print("Error: $e");
      return null;
    }
  }
}
