import 'dart:convert';
import 'package:argon_admin/app/constants/api_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/app/data/NetworkClient.dart';
import 'package:argon_admin/app/modules/dashboard_screen/controllers/dashboard_screen_controller.dart';
import 'package:argon_admin/app/modules/detail_screen/views/detail_screen_view.dart';
import 'package:argon_admin/main.dart';
import 'package:argon_admin/utilities/custome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import '../../../models/attendace_details_model.dart';
import '../../../models/holidayDataModel.dart';

class DetailScreenController extends GetxController {
  DashboardScreenController? dashboardScreenController;
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
  RxList<Data> dataEntryList = RxList<Data>([]);
  RxList<HolidayData> allHolidayList = RxList<HolidayData>([]);
  late RxInt selectedIndexForEntry;
  RxString totalTime = getTotalTime(0).obs;
  RxInt counter = 0.obs;

  @override
  void onInit() {
    Get.lazyPut(() => DashboardScreenController());
    dashboardScreenController = Get.find<DashboardScreenController>();
    selectedIndexForEntry = 0.obs;

    lastDateOfMonth = getLastDateOfMonth(date: selectedMonth.value);
    if (box.read(ArgumentConstant.userEmailForDetail) != null) {
      userEmail = box.read(ArgumentConstant.userEmailForDetail);
    }
    callApiForGetHoliday(context: Get.context!, isFromButton: true);
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
          attendanceDetailsList.addAll(dataList);
          if (!isNullEmptyOrFalse(attendanceDetailsList)) {
            if (selectedIndexForEntry.value == 0) {
              selectedIndexForEntry.value = attendanceDetailsList.length - 1;
              attendanceDetailsList.last.isSelected.value = true;
              if (!isNullEmptyOrFalse(attendanceDetailsList.last.data)) {
                totalTime.value = getTotalTime(
                    int.parse(attendanceDetailsList.last.data!.last.total!));
              }
            } else {
              attendanceDetailsList[selectedIndexForEntry.value]
                  .isSelected
                  .value = true;
              totalTime.value = getTotalTime(int.parse(
                  attendanceDetailsList[selectedIndexForEntry.value]
                      .data!
                      .last
                      .total!));
            }
            counter.value = 0;
            attendanceDetailsList.forEach((element) {
              if (isNullEmptyOrFalse(element.data)) {
                DateTime now = DateTime.now();
                if ((getDateFromString(element.date!,
                            formatter: "yyyy-MM-dd") !=
                        DateTime(now.year, now.month, now.day)) &&
                    (getDateFromString(element.date!, formatter: "yyyy-MM-dd")
                            .weekday !=
                        7)) {
                  bool isDateContains = false;
                  allHolidayList.forEach((element2) {
                    DateTime holidayDate1 = getDateFromString(element2.date1!,
                        formatter: "yyyy-MM-dd");
                    DateTime holidayDate2 = getDateFromString(element2.date2!,
                        formatter: "yyyy-MM-dd");

                    if (getDateFromString(element.date!, formatter: 'yyyy-MM-dd')
                                .isBefore(holidayDate2) &&
                            getDateFromString(element.date!, formatter: 'yyyy-MM-dd')
                                .isAfter(holidayDate1) ||
                        (DateTime(
                                getDateFromString(element.date!, formatter: 'yyyy-MM-dd')
                                    .year,
                                getDateFromString(element.date!,
                                        formatter: 'yyyy-MM-dd')
                                    .month,
                                getDateFromString(element.date!,
                                        formatter: 'yyyy-MM-dd')
                                    .day) ==
                            DateTime(holidayDate2.year, holidayDate2.month,
                                holidayDate2.day)) ||
                        (DateTime(
                                getDateFromString(element.date!,
                                        formatter: 'yyyy-MM-dd')
                                    .year,
                                getDateFromString(element.date!,
                                        formatter: 'yyyy-MM-dd')
                                    .month,
                                getDateFromString(element.date!,
                                        formatter: 'yyyy-MM-dd')
                                    .day) ==
                            DateTime(holidayDate1.year, holidayDate1.month, holidayDate1.day))) {
                    } else {
                      isDateContains = true;
                    }
                  });
                  if (isDateContains) {
                    counter.value++;
                  }
                }
              }
            });
          }
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

  callApiForGetHoliday(
      {required BuildContext context, bool isFromButton = false}) {
    hasData.value = false;
    FocusScope.of(context).unfocus();
    Map<String, dynamic> dict = {};
    dict["select_op"] = "get_all_holiday";
    FormData data = FormData.fromMap(dict);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.holiday,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: data,
      successCallback: (response, message) {
        hasData.value = true;
        Map<String, dynamic> m = jsonDecode(response) as Map<String, dynamic>;
        HolidayDataModel holidayListModel = HolidayDataModel.fromJson(m);
        allHolidayList.clear();
        if (!isNullEmptyOrFalse(holidayListModel.data)) {
          allHolidayList.addAll(holidayListModel.data!);
        }
        getAttendanceDetails(context: Get.context!);
      },
      failureCallback: (status, message) {
        hasData.value = true;
        print(" error");
        print(status);
      },
    );
  }
}
