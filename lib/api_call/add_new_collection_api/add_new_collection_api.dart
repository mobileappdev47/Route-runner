import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_runner/api_call/add_new_collection_api/add_new_collection_model.dart';
import 'package:route_runner/screens/collection_report/collection_report_controller.dart';
import 'package:route_runner/service/http_services.dart';
import 'package:route_runner/service/pref_services.dart';
import 'package:route_runner/utils/end_points.dart';
import 'package:route_runner/utils/pref_keys.dart';
CollectionReportController controller = Get.put(CollectionReportController());
class CustomerNewCollectionApi {
  static Future<AddNewCollectionModel> customerNewCollectionApi(BuildContext context,{
    required String location,
    required List machines
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${PrefService.getString(PrefKeys.registerToken)}",
        'Cookie': 'refreshToken=${PrefService.getString(PrefKeys.registerToken)}'
      };

      var body = json.encode({
        "employeeId": PrefService.getString(PrefKeys.employeeId),
        "locationId": location,
        "machines": machines
      });

      var response = await HttpService.postApi(
        url: "${EndPoints.addNewCollection}${PrefService.getString(PrefKeys.employeeId)}/$location",
        body: body,
        header: headers,
      );

      if (response?.statusCode == 201 || response?.statusCode ==200) {
        var decoded = jsonDecode(response!.body);

        print(decoded);

        if (decoded["success"] == true) {
          controller.locationsData.clear();

          controller.getLocation();

          Navigator.pop(context,true);
          Navigator.pop(context,true);

          // Get.to(() => CollectionReportScreen());
          return addNewCollectionModelFromJson(response.body);
        }
      } else {
        // Handle other status codes if needed
        print("HTTP Status Code: ${response?.statusCode}");
      }
      return AddNewCollectionModel();
    } catch (e, stackTrace) {
      print("Error: $e");
      print("Stack Trace: $stackTrace");
      return AddNewCollectionModel();
    }
  }
}
