import 'dart:convert';
import 'package:argon_admin/app/constants/color_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import '../../../models/attendace_details_model.dart';
import '../controllers/detail_screen_controller.dart';

class DetailScreenView extends GetWidget<DetailScreenController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('DetailScreenView'),
          centerTitle: true,
          leading: Text(""),
        ),
        body: (controller.hasData.isFalse)
            ? Center(
                child: CircularProgressIndicator(color: appTheme.primaryTheme),
              )
            : Container(
                padding: Spacing.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          controller.selectedMonth.value =
                              (await showMonthYearPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                            ),
                          ))!;

                          if (!isNullEmptyOrFalse(controller.selectedMonth)) {
                            controller.lastDateOfMonth = getLastDateOfMonth(
                                date: controller.selectedMonth.value);
                            controller.getAttendanceDetails(context: context);
                          }
                        },
                        child: Container(
                          height: MySize.getScaledSizeHeight(40),
                          width: MySize.getScaledSizeWidth(100),
                          margin: Spacing.only(
                              top: MySize.getScaledSizeHeight(10), bottom: 10),
                          decoration: BoxDecoration(
                            color: appTheme.primaryTheme,
                            borderRadius: BorderRadius.circular(
                                MySize.getScaledSizeHeight(5)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                              "${controller.selectedMonth.value.month} / ${controller.selectedMonth.value.year}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.getScaledSizeWidth(20))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: StickyHeadersTable(
                              scrollControllers: controller.tableController,
                              columnsLength: controller.titleColumn.length,
                              rowsLength:
                                  controller.attendanceDetailsList.length,
                              columnsTitleBuilder: (i) => TableCell.stickyRow(
                                  controller.titleColumn[i]),
                              rowsTitleBuilder: (i) =>
                                  TableCell.stickyColumn("${i + 1}"),
                              contentCellBuilder: (i, j) => TableCell.content(
                                  getContent(rowIndex: i, columnIndex: j),
                                  isIcon: (i == 2 || i == 3) ? true : false,
                                  icon: (i == 2) ? Icons.arrow_forward : null,
                                  onTap: (i == 2)
                                      ? () {
                                          controller
                                              .selectedIndexForEntry.value = j;
                                          controller.dataEntryList.clear();
                                          RxList<Data> data2 = RxList<Data>([]);
                                          controller
                                              .attendanceDetailsList[j].data!
                                              .forEach((element) {
                                            data2.add(element);
                                            controller.dataEntryList
                                                .add(element);
                                          });
                                        }
                                      : null,
                                  textStyle: TextStyle(
                                      fontSize:
                                          MySize.getScaledSizeHeight(12))),
                              legendCell: TableCell.legend("No"),
                            ),
                          ),
                          Expanded(
                            child: StickyHeadersTable(
                              scrollControllers: controller.tableController2,
                              columnsLength: controller.titleColumn2.length,
                              rowsLength: controller.dataEntryList.length,
                              columnsTitleBuilder: (i) => TableCell.stickyRow(
                                  controller.titleColumn2[i]),
                              rowsTitleBuilder: (i) =>
                                  TableCell.stickyColumn("${i + 1}"),
                              contentCellBuilder: (i, j) => TableCell.content(
                                  getContact2(rowIndex: i, columnIndex: j),
                                  isIcon: (i == 2) ? true : false,
                                  icon: (i == 2) ? Icons.edit : null,
                                  onTap: (i == 2)
                                      ? () {
                                          controller.editTime =
                                              controller.dataEntryList[j].time!;
                                          controller.editTimeController.text =
                                              getStringFromDateTime(
                                                  time: controller.editTime);
                                          openEditDialog(
                                              context: context,
                                              timeEntryList:
                                                  controller.dataEntryList,
                                              selectedIndex: j);
                                        }
                                      : null,
                                  textStyle: TextStyle(
                                      fontSize:
                                          MySize.getScaledSizeHeight(12))),
                              legendCell: TableCell.legend("No"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  openEditDialog(
      {required BuildContext context,
      required RxList<Data> timeEntryList,
      required int selectedIndex}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getTextField(
                        hintText: "Enter Time",
                        readonly: true,
                        onTap: () async {
                          controller.editTime = await openTimePicker(
                              context: context,
                              selectedTime: controller.editTime,
                              selectedIndex: selectedIndex);

                          controller.editTimeController.text =
                              getStringFromDateTime(time: controller.editTime);
                        },
                        textEditingController: controller.editTimeController),
                    Space.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              height: MySize.getScaledSizeHeight(35),
                              width: MySize.getScaledSizeWidth(100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MySize.getScaledSizeHeight(10)),
                                  border:
                                      Border.all(color: appTheme.primaryTheme)),
                              alignment: Alignment.center,
                              child: Text("Cancel")),
                        ),
                        Space.width(15),
                        InkWell(
                          onTap: () {
                            print(
                                "Update Index := ${controller.selectedIndexForEntry}");
                            updateTimeEntry(
                                selectedIndex: selectedIndex, context: context);
                          },
                          child: Container(
                              height: MySize.getScaledSizeHeight(35),
                              width: MySize.getScaledSizeWidth(100),
                              decoration: BoxDecoration(
                                  color: appTheme.primaryTheme,
                                  borderRadius: BorderRadius.circular(
                                      MySize.getScaledSizeHeight(10)),
                                  border:
                                      Border.all(color: appTheme.primaryTheme)),
                              alignment: Alignment.center,
                              child: Text(
                                "Update",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<DateTime> openTimePicker(
      {required BuildContext context,
      required DateTime selectedTime,
      required int selectedIndex}) async {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (!isNullEmptyOrFalse(time)) {
      DateTime pickedTime = DateTime(
          controller.dataEntryList[selectedIndex].date!.year,
          controller.dataEntryList[selectedIndex].date!.month,
          controller.dataEntryList[selectedIndex].date!.day,
          time!.hour,
          time.minute);
      if (controller.dataEntryList[selectedIndex].st == "in") {
        if (selectedIndex == 0) {
          if (controller.dataEntryList.length == 1) {
            return pickedTime;
          } else {
            if (pickedTime
                .isAfter(controller.dataEntryList[selectedIndex + 1].time!)) {
              getSnackBar(context: context, text: "Invalid Time");
            } else {
              return pickedTime;
            }
          }
        } else {
          if (selectedIndex + 1 == controller.dataEntryList.length) {
            // In is located at last position....
            if (pickedTime
                .isBefore(controller.dataEntryList[selectedIndex - 1].time!)) {
              getSnackBar(context: context, text: "Invalid Time");
            } else {
              return pickedTime;
            }
          } else {
            if (pickedTime
                .isBefore(controller.dataEntryList[selectedIndex - 1].time!)) {
              getSnackBar(context: context, text: "Invalid Time");
            } else if (pickedTime
                .isAfter(controller.dataEntryList[selectedIndex + 1].time!)) {
              getSnackBar(context: context, text: "Invalid Time");
            } else {
              return pickedTime;
            }
          }
        }
      } else {
        if (selectedIndex + 1 == controller.dataEntryList.length) {
          if (pickedTime
              .isBefore(controller.dataEntryList[selectedIndex - 1].time!)) {
            getSnackBar(context: context, text: "Invalid Time");
          } else {
            return pickedTime;
          }
        } else {
          if (pickedTime
              .isAfter(controller.dataEntryList[selectedIndex + 1].time!)) {
            getSnackBar(context: context, text: "Invalid Time");
          } else if (pickedTime
              .isBefore(controller.dataEntryList[selectedIndex - 1].time!)) {
            getSnackBar(context: context, text: "Invalid Time");
          } else {
            return pickedTime;
          }
        }
      }
    }
    return controller.editTime;
  }

  updateTimeEntry({required int selectedIndex, required BuildContext context}) {
    Map<String, dynamic> dict = {};
    if (controller.editTime == controller.dataEntryList[selectedIndex].time) {
      Get.back();
    } else {
      if (controller.dataEntryList[selectedIndex].st == "in") {
        if (selectedIndex == 0) {
          if (controller.dataEntryList.length == 1) {
            dict["data"] = jsonEncode([
              {
                "email": controller.dataEntryList[selectedIndex].email,
                "st": "in",
                "total": "0",
                "date": getDateInFormat(
                    date: controller.dataEntryList[selectedIndex].date!),
                "time": getStringTimeFromDateTime(date: controller.editTime)
              }
            ]);
          } else {
            Duration diff = controller.dataEntryList[selectedIndex].time!
                .difference(controller.editTime);
            print("Diff:= ${diff.inSeconds}");
            controller.dataEntryList[selectedIndex].time = controller.editTime;

            for (int i = selectedIndex + 1;
                i < controller.dataEntryList.length;
                i++) {
              controller.dataEntryList[i].total =
                  (int.parse(controller.dataEntryList[i].total!) +
                          diff.inSeconds)
                      .toString();
              print("Total := ${controller.dataEntryList[i].total}");
            }
            List<Map<String, dynamic>> test = [];
            controller.dataEntryList.forEach((element) {
              test.add({
                "email": element.email,
                "st": element.st,
                "total": element.total,
                "date": getDateInFormat(date: element.date!),
                "time": getStringTimeFromDateTime(date: element.time!)
              });
            });
            dict["data"] = jsonEncode(test);
          }
        } else {
          if (selectedIndex + 1 == controller.dataEntryList.length) {
            Duration diff = controller.dataEntryList[selectedIndex].time!
                .difference(controller.editTime);

            controller.dataEntryList[selectedIndex].time = controller.editTime;
            List<Map<String, dynamic>> test = [];
            controller.dataEntryList.forEach((element) {
              test.add({
                "email": element.email,
                "st": element.st,
                "total": element.total,
                "date": getDateInFormat(date: element.date!),
                "time": getStringTimeFromDateTime(date: element.time!)
              });
            });
            dict["data"] = jsonEncode(test);
          } else {
            Duration diff = controller.dataEntryList[selectedIndex].time!
                .difference(controller.editTime);
            print("Diff:= ${diff.inSeconds}");
            controller.dataEntryList[selectedIndex].time = controller.editTime;

            for (int i = selectedIndex + 1;
                i < controller.dataEntryList.length;
                i++) {
              controller.dataEntryList[i].total =
                  (int.parse(controller.dataEntryList[i].total!) +
                          diff.inSeconds)
                      .toString();
              print("Total := ${controller.dataEntryList[i].total}");
            }
            List<Map<String, dynamic>> test = [];
            controller.dataEntryList.forEach((element) {
              test.add({
                "email": element.email,
                "st": element.st,
                "total": element.total,
                "date": getDateInFormat(date: element.date!),
                "time": getStringTimeFromDateTime(date: element.time!)
              });
            });
            dict["data"] = jsonEncode(test);
          }
        }
      } else {
        if (selectedIndex + 1 == controller.dataEntryList.length) {
          Duration diff = controller.editTime
              .difference(controller.dataEntryList[selectedIndex].time!);
          controller.dataEntryList[selectedIndex].time = controller.editTime;
          controller.dataEntryList[selectedIndex].total =
              (int.parse(controller.dataEntryList[selectedIndex].total!) +
                      diff.inSeconds)
                  .toString();
          List<Map<String, dynamic>> test = [];
          controller.dataEntryList.forEach((element) {
            test.add({
              "email": element.email,
              "st": element.st,
              "total": element.total,
              "date": getDateInFormat(date: element.date!),
              "time": getStringTimeFromDateTime(date: element.time!)
            });
          });
          dict["data"] = jsonEncode(test);
        } else {
          dict["data"] = getEncodedJson(
              time1: controller.editTime,
              time2: controller.dataEntryList[selectedIndex].time!,
              selectedIndex: selectedIndex);
        }
      }
    }
    if (!isNullEmptyOrFalse(dict)) {
      dict["date_st"] =
          getDateInFormat(date: controller.dataEntryList[selectedIndex].date!);
      dict["email_st"] = controller.dataEntryList[selectedIndex].email;
      Get.back();
      print(dict);
      controller.callUpdateAttendance(context: context, dict: dict);
    }
  }

  String getEncodedJson(
      {required DateTime time1,
      required DateTime time2,
      required int selectedIndex,
      bool isForLast = false}) {
    List<Map<String, dynamic>> test = [];
    Duration diff = time1.difference(time2);
    print("Diff:= ${diff.inSeconds}");
    if (isForLast) {
      controller.dataEntryList[selectedIndex].time = controller.editTime;
      controller.dataEntryList[selectedIndex].total =
          (int.parse(controller.dataEntryList[selectedIndex].total!) +
                  diff.inSeconds)
              .toString();
      List<Map<String, dynamic>> test = [];
      controller.dataEntryList.forEach((element) {
        test.add({
          "email": element.email,
          "st": element.st,
          "total": element.total,
          "date": getDateInFormat(date: element.date!),
          "time": getStringTimeFromDateTime(date: element.time!)
        });
      });
    } else {
      controller.dataEntryList[selectedIndex].time = controller.editTime;
      for (int i = selectedIndex + 1;
          i < controller.dataEntryList.length;
          i++) {
        controller.dataEntryList[i].total =
            (int.parse(controller.dataEntryList[i].total!) + diff.inSeconds)
                .toString();
        print("Total := ${controller.dataEntryList[i].total}");
      }

      controller.dataEntryList.forEach((element) {
        test.add({
          "email": element.email,
          "st": element.st,
          "total": element.total,
          "date": getDateInFormat(date: element.date!),
          "time": getStringTimeFromDateTime(date: element.time!)
        });
      });
    }

    return jsonEncode(test);
  }

  String getStringTimeFromDateTime({required DateTime date}) {
    return "${strDigits(date.hour)}:${strDigits(date.minute)}:${strDigits(date.second)}";
  }

  String getContent({required int rowIndex, required int columnIndex}) {
    if (rowIndex == 0) {
      return "${DateFormat("dd-MM-yyyy").format(getDateFromString(controller.attendanceDetailsList[columnIndex].date!, formatter: "yyyy-MM-dd"))}";
    } else {
      if (!isNullEmptyOrFalse(
          controller.attendanceDetailsList[columnIndex].data)) {
        return getTotalTime(int.parse(controller
            .attendanceDetailsList[columnIndex].data!.last.total
            .toString()));
      }
      return getTotalTime(0);
    }
  }

  String getContact2({required int rowIndex, required int columnIndex}) {
    if (rowIndex == 0) {
      return getStringFromTime(
          time: getTimeFromDateTime(
              dateTime: controller.dataEntryList[columnIndex].time!));
    } else {
      return "${controller.dataEntryList[columnIndex].st!.toUpperCase()}";
    }
  }
}

String getStringFromTime({required TimeOfDay time}) {
  return "${strDigits(time.hour)}:${strDigits(time.minute)}";
}

String getDateInFormat({required DateTime date}) {
  return "${strDigits(date.year)}-${strDigits(date.month)}-${strDigits(date.day)}";
}

String getStringFromDateTime({required DateTime time}) {
  return "${time.hour}:${time.minute}";
}

TimeOfDay getTimeFromDateTime({required DateTime dateTime}) {
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

getTotalTime(int sec) {
  Duration diff = Duration(seconds: sec);
  // totalSecond = int.parse(checkInOutModel.data!.total.toString());
  String h = strDigits(diff.inHours.remainder(24));
  String mm = strDigits(diff.inMinutes.remainder(60));
  String ss = strDigits(diff.inSeconds.remainder(60));
  return '$h : $mm : $ss';
}

String strDigits(int n) {
  return n.toString().padLeft(2, '0');
}

class TableCell extends StatelessWidget {
  TableCell.content(
    this.text, {
    this.textStyle,
    this.isIcon = false,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
    this.icon,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.legend(
    this.text, {
    this.textStyle,
    this.isIcon = false,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
    this.icon,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  TableCell.stickyRow(
    this.text, {
    this.textStyle,
    this.isIcon = false,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
    this.icon,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.stickyColumn(
    this.text, {
    this.textStyle,
    this.isIcon = false,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
    this.icon,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 0.0);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;
  final bool isIcon;
  final IconData? icon;
  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellHeight,
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: (isIcon)
                    ? Icon(icon)
                    : Text(
                        text,
                        style: textStyle,
                        maxLines: 2,
                        textAlign: _textAlign,
                      ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
      ),
    );
  }
}
