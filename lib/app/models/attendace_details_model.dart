import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceDetailsModel {
  String? date;
  RxBool isSelected = false.obs;
  List<Data>? data = [];

  AttendanceDetailsModel({this.date, this.data});

  AttendanceDetailsModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? st;
  String? total;
  DateTime? date;
  DateTime? time;

  Data({this.id, this.email, this.st, this.total, this.date, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    st = json['st'];
    total = json['total'];
    date = getDateFromString(json['date'], formatter: "yyyy-MM-dd");
    time = DateTime(
        date!.year,
        date!.month,
        date!.day,
        int.parse(json["time"].toString().split(":")[0]),
        int.parse(json["time"].toString().split(":")[1]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['st'] = this.st;
    data['total'] = this.total;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
