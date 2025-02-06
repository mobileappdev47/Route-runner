import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:route_runner/api_call/auth/signIn_api/sign_in_model.dart';
import 'package:route_runner/common/pop_up.dart';
import 'package:route_runner/screens/dash_board/dash_board_screen.dart';
import 'package:route_runner/service/http_services.dart';
import 'package:route_runner/service/pref_services.dart';
import 'package:route_runner/utils/end_points.dart';
import 'package:route_runner/utils/pref_keys.dart';

class CustomerSignInApi {
  static customerSignInApi({required String email, required String password}) async {
    try {
      var response = await HttpService.postApi(
        url: EndPoints.login,
        body: {
          "email": email.removeAllWhitespace,
          "password": password,
        },
      );

      if (response?.statusCode == 200) {
        var decoded = jsonDecode(response!.body);

        print(decoded);

        if (decoded["success"] == true) {
          PrefService.setValue(PrefKeys.login, true);
          flutterToast(decoded["message"]);
          PrefService.setValue(PrefKeys.firstName, decoded['firstname']);
          PrefService.setValue(PrefKeys.lastName, decoded['lastname']);
          PrefService.setValue(PrefKeys.email, decoded['email']);
          PrefService.setValue(PrefKeys.employeeId, decoded['_id']);
          print("==============================${PrefService.setValue(PrefKeys.email, decoded['email'])}");
          PrefService.setValue(PrefKeys.mobileNumber, decoded['phone']);
          PrefService.setValue(PrefKeys.registerToken, decoded['token']);
          print("======================${PrefService.setValue(PrefKeys.registerToken, decoded['token'])}");
          if(decoded['image'].length != 0 ) {
            PrefService.setValue(PrefKeys.userImage, decoded['image'][0]);
          }
          Get.offAll(() => DashBoardScreen());
          return signInModelFromJson(response.body);
        } else {
          // Handle other success scenarios if needed
          print("Success is false: ${decoded["message"]}");
        }
      } else {

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Invalid credential'),
          ),
        );

        print("HTTP Status Code: ${response?.statusCode}");
        print("Response Body: ${response?.body}");

      }
     return SignInModel();
    } catch (e) {

      const SnackBar(content: Text('Wrong email and password'));
      print("Error: $e");

      return SignInModel();
    }
  }
}
