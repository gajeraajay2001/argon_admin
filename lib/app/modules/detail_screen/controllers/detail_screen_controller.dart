import 'dart:convert';

import 'package:argon_admin/app/constants/api_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/app/data/NetworkClient.dart';
import 'package:argon_admin/main.dart';
import 'package:argon_admin/utilities/custome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '../../../models/attendace_details_model.dart';

class DetailScreenController extends GetxController {
  Rx<DateTime> selectedMonth = DateTime.now().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController editTimeController = TextEditingController();
  DateTime editTime = DateTime.now();
  late DateTime lastDateOfMonth;
  RxBool hasData = false.obs;
  String? userEmail;
  List titleColumn = ["Date", "Total Time", ""];
  List titleColumn2 = ["Time", "Status", "Edit"];
  RxList<AttendanceDetailsModel> attendanceDetailsList =
      RxList<AttendanceDetailsModel>([]);
  RxList<AttendanceDetailsModel> dataList = RxList<AttendanceDetailsModel>([]);
  ScrollControllers tableController = ScrollControllers();
  ScrollControllers tableController2 = ScrollControllers();
  RxList<Data> dataEntryList = RxList<Data>([]);
  late RxInt selectedIndexForEntry;
  @override
  void onInit() {
    selectedIndexForEntry = 0.obs;
    print("Selecvted Index: == = = =  ${selectedIndexForEntry}");
    lastDateOfMonth = getLastDateOfMonth(date: selectedMonth.value);
    if (box.read(ArgumentConstant.userEmailForDetail) != null) {
      userEmail = box.read(ArgumentConstant.userEmailForDetail);
    }
    print(lastDateOfMonth.toString() + userEmail!);
    getAttendanceDetails(context: Get.context!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getAttendanceDetails({required BuildContext context}) async {
    dataEntryList.clear();
    dataList.clear();
    attendanceDetailsList.clear();
    hasData.value = false;
    Map<String, dynamic> dict = {};
    if (selectedMonth.value.month == DateTime.now().month) {
      lastDateOfMonth = DateTime.now();
    }
    dict["email"] = userEmail;
    dict["date1"] =
        "${selectedMonth.value.year}-${selectedMonth.value.month}-01";
    dict["date2"] =
        "${selectedMonth.value.year}-${selectedMonth.value.month}-${lastDateOfMonth.day}";
    FormData formData = FormData.fromMap(dict);
    NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.userMonthData,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (response, message) {
        hasData.value = true;
        List res = jsonDecode(response);
        if (!isNullEmptyOrFalse(res)) {
          res.forEach((element) {
            AttendanceDetailsModel attendanceDetailsModel =
                AttendanceDetailsModel.fromJson(element);
            dataList.add(attendanceDetailsModel);
          });
          print("selectedIndex : = ${selectedIndexForEntry}");
          attendanceDetailsList.addAll(dataList.reversed.toList());
          if (!isNullEmptyOrFalse(
              attendanceDetailsList[selectedIndexForEntry.value].data)) {
            RxList<Data> data2 = RxList<Data>([]);
            attendanceDetailsList[selectedIndexForEntry.value]
                .data!
                .forEach((element) {
              data2.add(element);
              dataEntryList.add(element);
            });
          }
        }
      },
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error ");
      },
    );
  }

  callUpdateAttendance(
      {required BuildContext context,
      required Map<String, dynamic> dict}) async {
    FormData formData = FormData.fromMap(dict);
    NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateAttendance,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (response, message) {
        hasData.value = true;
        getAttendanceDetails(context: context);
        print(response);
        print("Yessssssssssssssssssss");
      },
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error ");
      },
    );
  }
}
