import 'package:argon_admin/utilities/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../main.dart';
import '../../../../utilities/custome_dialog.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/sizeConstant.dart';
import '../controllers/apply_holiday_controller.dart';

class ApplyHolidayView extends GetWidget<ApplyHolidayController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return GetBuilder<ApplyHolidayController>(
        init: ApplyHolidayController(),
        builder: (controller) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  width: MySize.getWidth(500),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacing.height(20),
                        Text(
                          "Add Holiday",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Spacing.height(20),
                        Obx(() {
                          return Container(
                            width: MySize.getWidth(500),
                            child: SfDateRangePicker(
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                controller.range.value = args.value;

                                // print(range.endDate);
                              },
                              selectionMode: DateRangePickerSelectionMode.range,
                              //showTodayButton: true,
                              initialSelectedRange: controller.range.value,
                              initialDisplayDate: DateTime.now(),
                              minDate: DateTime.now(),
                            ),
                          );
                        }),
                        Padding(
                          padding: EdgeInsets.only(top: MySize.size20!),
                          child: Container(
                            width: MySize.getWidth(500),
                            child: Align(
                              child: Text(
                                "Holiday Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ),
                        Spacing.height(10),
                        Container(
                          width: MySize.getWidth(500),
                          child: getTextField(
                              maxLine: 3,
                              textEditingController:
                                  controller.reasonController.value,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter name";
                                }
                                return null;
                              }),
                        ),
                        Spacing.height(30),
                        Center(
                          child: FlatButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                addHoliday(
                                    context: context, controller: controller);
                              }
                            },
                            color: Colors.blue,
                            child: Text(
                              "Add Holiday",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MySize.size20!,
                  ),
                  child: Obx(() {
                    return Column(
                      children: [
                        Text(
                          "Holidays",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Spacing.height(20),
                        Expanded(
                          child: (controller.hasData.value)
                              ? ((controller.allHolidayList.isNotEmpty)
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MySize.getWidth(100)),
                                      child: ListView.separated(
                                        itemBuilder: (context, i) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: MySize.getWidth(15),
                                                vertical: MySize.size10!),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MySize.size12!),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Holiday date : ",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                MySize.size16,
                                                          ),
                                                        ),
                                                        Space.width(10),
                                                        Text(
                                                          controller
                                                                  .allHolidayList[
                                                                      i]
                                                                  .date1
                                                                  .toString() +
                                                              " - " +
                                                              controller
                                                                  .allHolidayList[
                                                                      i]
                                                                  .date2
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                MySize.size16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            _asyncConfirmDialog(
                                                                context,
                                                                i,
                                                                controller);
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Space.height(5),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Reason : ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MySize.size16,
                                                      ),
                                                    ),
                                                    Space.width(10),
                                                    Expanded(
                                                      child: Text(
                                                        controller
                                                            .allHolidayList[i]
                                                            .des
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              MySize.size16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Space.height(10),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, i) {
                                          return Space.height(20);
                                        },
                                        itemCount:
                                            controller.allHolidayList.length,
                                        reverse: false,
                                        padding: EdgeInsets.zero,
                                      ),
                                    )
                                  : Center(
                                      child: Text("No any Holidays found."),
                                    ))
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          );
        });
  }

  addHoliday(
      {required BuildContext context,
      required ApplyHolidayController controller}) {
    DateTime fromDate = controller.range.value.startDate!;
    DateTime? toDate;
    if (controller.range.value.endDate != null) {
      toDate = controller.range.value.endDate!;
    } else {
      toDate = controller.range.value.startDate!;
    }

    bool base = false;
    controller.allHolidayList.forEach((element) {
      if ((toDate!.isBefore(getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')) &&
              fromDate.isAfter(getDateFromString(element.date1!,
                  formatter: 'yyyy-MM-dd'))) ||
          (toDate.isBefore(
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')) &&
              toDate.isAfter(getDateFromString(element.date1!,
                  formatter: 'yyyy-MM-dd'))) ||
          (fromDate.isBefore(
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')) &&
              fromDate.isAfter(getDateFromString(element.date1!,
                  formatter: 'yyyy-MM-dd'))) ||
          (DateTime(
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')
                      .year,
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')
                      .month,
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')
                      .day) ==
              DateTime(toDate.year, toDate.month, toDate.day)) ||
          (DateTime(
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd')
                      .year,
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd').month,
                  getDateFromString(element.date2!, formatter: 'yyyy-MM-dd').day) ==
              DateTime(fromDate.year, fromDate.month, fromDate.day)) ||
          (DateTime(
                getDateFromString(element.date1!, formatter: 'yyyy-MM-dd').year,
                getDateFromString(element.date1!, formatter: 'yyyy-MM-dd')
                    .month,
                getDateFromString(element.date1!, formatter: 'yyyy-MM-dd').day,
              ) ==
              DateTime(
                toDate.year,
                toDate.month,
                toDate.day,
              )) ||
          (DateTime(
                getDateFromString(element.date1!, formatter: 'yyyy-MM-dd').year,
                getDateFromString(element.date1!, formatter: 'yyyy-MM-dd')
                    .month,
                getDateFromString(element.date1!, formatter: 'yyyy-MM-dd').day,
              ) ==
              DateTime(
                fromDate.year,
                fromDate.month,
                fromDate.day,
              ))) {
        // isDateBetween = true;
        base = true;
      }
    });
    if (!base) {
      controller.callApiForApplyHolidayEntry(context: context);
    } else {
      app.resolve<CustomDialogs>().getDialog(
          title: "Leave", desc: "Already leave applied on selected day.");
    }
    ;
  }

  _asyncConfirmDialog(BuildContext context, int index, controller) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Holiday'),
          content: const Text('Are you sure you want to delete your Holiday?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
                controller.callApiForDeleteHoliday(
                    context: Get.context!,
                    isFromButton: true,
                    id: controller.allHolidayList[index].id.toString());
              },
            )
          ],
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    controller.range.value = args.value;

    // print(range.endDate);
  }
}
