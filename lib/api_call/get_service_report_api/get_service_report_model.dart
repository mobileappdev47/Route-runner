// To parse this JSON data, do
//
//     final getMachinesModel = getMachinesModelFromJson(jsonString);

import 'dart:convert';

GetServiceReportModel getServiceReportModelFromJson(String str) => GetServiceReportModel.fromJson(json.decode(str));

String getServiceReportModelToJson(GetServiceReportModel data) => json.encode(data.toJson());

class GetServiceReportModel {
  bool? success;
  String? message;
  List<ServiceReports>? serviceReports;
  int? totalPages;
  int? currentPage;

  GetServiceReportModel(
      {this.success,
        this.message,
        this.serviceReports,
        this.totalPages,
        this.currentPage});

  GetServiceReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['serviceReports'] != null) {
      serviceReports = <ServiceReports>[];
      json['serviceReports'].forEach((v) {
        serviceReports!.add(ServiceReports.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (serviceReports != null) {
      data['serviceReports'] =
          serviceReports!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    return data;
  }
}

class ServiceReports {
  String? sId;
  String? machineNumber;
  String? serialNumber;
  String? auditNumber;
  String? date;
  String? time;
  String? employeeName;
  String? serviceRequested;
  String? image;
  int? iV;

  ServiceReports(
      {this.sId,
        this.machineNumber,
        this.serialNumber,
        this.auditNumber,
        this.date,
        this.time,
        this.employeeName,
        this.serviceRequested,
        this.image,
        this.iV});

  ServiceReports.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    machineNumber = json['machineNumber'];
    serialNumber = json['serialNumber'];
    auditNumber = json['auditNumber'];
    date = json['date'];
    time = json['time'];
    employeeName = json['employeeName'];
    serviceRequested = json['serviceRequested'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['machineNumber'] = machineNumber;
    data['serialNumber'] = serialNumber;
    data['auditNumber'] = auditNumber;
    data['date'] = date;
    data['time'] = time;
    data['employeeName'] = employeeName;
    data['serviceRequested'] = serviceRequested;
    data['image'] = image;
    data['__v'] = iV;
    return data;
  }
}
