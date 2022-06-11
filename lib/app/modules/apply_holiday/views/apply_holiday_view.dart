import 'package:argon_admin/utilities/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                                controller.callApiForApplyHolidayEntry(
                                    context: context);
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
                                                        // IconButton(
                                                        //   onPressed: () {
                                                        //     DateTime
                                                        //         fromDate =
                                                        //         getDateFromString(
                                                        //             controller
                                                        //                 .allHolidayList[
                                                        //                     i]
                                                        //                 .dateFrom
                                                        //                 .toString(),
                                                        //             formatter:
                                                        //                 "yyyy-MM-dd");
                                                        //     DateTime toDate =
                                                        //         getDateFromString(
                                                        //             controller
                                                        //                 .allHolidayList[
                                                        //                     i]
                                                        //                 .dateTo
                                                        //                 .toString(),
                                                        //             formatter:
                                                        //                 "yyyy-MM-dd");
                                                        //     controller.range
                                                        //             .value =
                                                        //         PickerDateRange(
                                                        //             fromDate,
                                                        //             toDate);
                                                        //     print(controller
                                                        //         .range.value);
                                                        //   },
                                                        //   icon: Icon(
                                                        //     Icons.edit,
                                                        //     color:
                                                        //         Colors.blue,
                                                        //   ),
                                                        // ),
                                                        // Space.width(15),
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
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Status : ",
                                                //       style: TextStyle(
                                                //         color: Colors.black,
                                                //         fontWeight:
                                                //             FontWeight.bold,
                                                //         fontSize:
                                                //             MySize.size16,
                                                //       ),
                                                //     ),
                                                //     // Space.width(10),
                                                //     // Container(
                                                //     //   padding: EdgeInsets
                                                //     //       .symmetric(
                                                //     //     horizontal: MySize
                                                //     //         .getWidth(
                                                //     //             12),
                                                //     //     vertical:
                                                //     //         MySize.size10!,
                                                //     //   ),
                                                //     //   decoration:
                                                //     //       BoxDecoration(
                                                //     //     color: (controller
                                                //     //                 .allHolidayList[
                                                //     //                     i]
                                                //     //                 .status
                                                //     //                 .toString() ==
                                                //     //             "in_verify")
                                                //     //         ? Colors.brown
                                                //     //         : (controller
                                                //     //                     .allHolidayList[
                                                //     //                         i]
                                                //     //                     .status
                                                //     //                     .toString() ==
                                                //     //                 "verified")
                                                //     //             ? Colors.green
                                                //     //             : Colors.red,
                                                //     //     borderRadius:
                                                //     //         BorderRadius
                                                //     //             .circular(
                                                //     //       MySize.size15!,
                                                //     //     ),
                                                //     //   ),
                                                //     //   child: Text(
                                                //     //     (controller
                                                //     //                 .allHolidayList[
                                                //     //                     i]
                                                //     //                 .status
                                                //     //                 .toString() ==
                                                //     //             "in_verify")
                                                //     //         ? "Pending"
                                                //     //         : (controller
                                                //     //                     .allHolidayList[
                                                //     //                         i]
                                                //     //                     .status
                                                //     //                     .toString() ==
                                                //     //                 "rejected")
                                                //     //             ? "Rejected"
                                                //     //             : "Approved",
                                                //     //     style: TextStyle(
                                                //     //       color: Colors.white,
                                                //     //       fontWeight:
                                                //     //           FontWeight.w500,
                                                //     //       fontSize:
                                                //     //           MySize.size16,
                                                //     //     ),
                                                //     //   ),
                                                //     // ),
                                                //   ],
                                                // ),
                                                // Space.height(9),
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
