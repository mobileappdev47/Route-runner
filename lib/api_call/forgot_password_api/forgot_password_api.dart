import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:route_runner/api_call/auth/signIn_api/sign_in_model.dart';
import 'package:route_runner/api_call/forgot_password_api/forgot_password_model.dart';
import 'package:route_runner/common/pop_up.dart';
import 'package:route_runner/screens/dash_board/dash_board_screen.dart';
import 'package:route_runner/service/http_services.dart';
import 'package:route_runner/service/pref_services.dart';
import 'package:route_runner/utils/end_points.dart';
import 'package:route_runner/utils/pref_keys.dart';

class ForgotPasswordApi {
  static forgotPasswordApi({required String email,}) async {
    try {
      var response = await HttpService.postApi(
        url: EndPoints.forgotPassword,
        body: {
          "email": email.toString().removeAllWhitespace,
        },
      );

      if (response?.statusCode == 200) {
        var decoded = jsonDecode(response!.body);

        print(decoded);

        if (decoded["success"] == true) {

          return forgotPasswordModelFromJson(response.body);
        } else {
          // Handle other success scenarios if needed
          print("Success is false: ${decoded["message"]}");
        }
      } else {


        var decoded = jsonDecode(response!.body);
        errorToast(decoded["message"]);
        print("HTTP Status Code: ${response?.statusCode}");
        print("Response Body: ${response?.body}");

      }
      return ForgotPasswordModel();
    } catch (e) {

      print("Error: $e");

      return ForgotPasswordModel();
    }
  }
}