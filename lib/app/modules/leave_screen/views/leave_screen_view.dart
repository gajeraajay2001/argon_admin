import 'package:argon_admin/app/constants/color_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/get_all_leaves_model.dart';
import '../controllers/leave_screen_controller.dart';

class LeaveScreenView extends GetWidget<LeaveScreenController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return GetBuilder<LeaveScreenController>(
        init: LeaveScreenController(),
        builder: (controller) {
          return Obx(() {
            return (controller.hasData.isFalse)
                ? Center(
                    child:
                        CircularProgressIndicator(color: appTheme.primaryTheme),
                  )
                : Container(
                    padding: Spacing.only(top: 50, left: 50, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: PopupMenuButton(
                                offset: Offset(0, 50),
                                itemBuilder: (context) {
                                  return List.generate(
                                      controller.filterList.length,
                                      (index) => PopupMenuItem(
                                            child: Text(
                                                controller.filterList[index]),
                                            onTap: () {
                                              controller.selectedFilter.value =
                                                  controller.filterList[index];
                                              controller.getFilteredData(
                                                  status: (index == 0)
                                                      ? "all"
                                                      : (index == 1)
                                                          ? "in_verify"
                                                          : (index == 2)
                                                              ? "verified"
                                                              : "rejected");
                                            },
                                          ));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      MySize.getScaledSizeHeight(5),
                                    ),
                                  ),
                                  child: Container(
                                    height: MySize.getScaledSizeHeight(40),
                                    width: MySize.getScaledSizeWidth(120),
                                    padding: Spacing.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: appTheme.primaryTheme,
                                        borderRadius: BorderRadius.circular(
                                            MySize.getScaledSizeHeight(5))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.selectedFilter.value,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Space.height(10),
                        Expanded(
                          child: Wrap(
                              spacing: MySize.getScaledSizeWidth(10),
                              runSpacing: MySize.getScaledSizeHeight(10),
                              children: List.generate(
                                  controller.allLeaveList.length, (index) {
                                return Container(
                                  height: MySize.getScaledSizeHeight(220),
                                  width: MySize.getScaledSizeWidth(260),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: appTheme.primaryTheme,
                                          width: MySize.getScaledSizeWidth(2)),
                                      borderRadius: BorderRadius.circular(
                                          MySize.getScaledSizeHeight(10))),
                                  padding: Spacing.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Name := ${controller.allLeaveList[index].name}"),
                                      Space.height(10),
                                      Text(
                                          "Email := ${controller.allLeaveList[index].email}"),
                                      Space.height(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "From := ${controller.allLeaveList[index].dateFrom}"),
                                          Text(
                                              "To := ${controller.allLeaveList[index].dateTo}"),
                                        ],
                                      ),
                                      Space.height(10),
                                      Text(
                                          "Reason := ${controller.allLeaveList[index].reason}"),
                                      Space.height(10),
                                      Row(
                                        children: [
                                          Text("Status : "),
                                          Space.width(5),
                                          GestureDetector(
                                            onTap: () {
                                              openDialogForLeave(
                                                  context: context,
                                                  leaveData: controller
                                                      .allLeaveList[index],
                                                  controller: controller);
                                            },
                                            child: Container(
                                                padding: Spacing.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: (controller
                                                                .allLeaveList[
                                                                    index]
                                                                .status ==
                                                            "in_verify")
                                                        ? appTheme.primaryTheme
                                                        : (controller
                                                                    .allLeaveList[
                                                                        index]
                                                                    .status ==
                                                                "verified")
                                                            ? Colors.green
                                                            : Colors.red,
                                                    borderRadius: BorderRadius
                                                        .circular(MySize
                                                            .getScaledSizeHeight(
                                                                5))),
                                                child: Text(
                                                  (controller
                                                              .allLeaveList[
                                                                  index]
                                                              .status ==
                                                          "in_verify")
                                                      ? "Pending"
                                                      : (controller
                                                                  .allLeaveList[
                                                                      index]
                                                                  .status ==
                                                              "verified")
                                                          ? "Approved"
                                                          : "Rejected",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ],
                                      ),
                                      Space.height(10),
                                    ],
                                  ),
                                );
                              }).toList()),
                        )
                        //   child: GridView.builder(
                        //       gridDelegate:
                        //           SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: 5,
                        //               childAspectRatio: 1.60,
                        //               crossAxisSpacing:
                        //                   MySize.getScaledSizeHeight(15),
                        //               mainAxisSpacing:
                        //                   MySize.getScaledSizeHeight(15)),
                        //       itemCount: controller.allLeaveList.length,
                        //       itemBuilder: (context, index) {
                        //         return
                        //       }),
                        // ),
                      ],
                    ),
                  );
          });
        });
  }

  openDialogForLeave(
      {required BuildContext context,
      required LeaveData leaveData,
      required LeaveScreenController controller}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                          controller.leaveRejectAndApprove(
                              context: context,
                              operation: "rejected",
                              id: leaveData.id!);
                        },
                        child: Container(
                          height: MySize.getScaledSizeHeight(40),
                          width: MySize.getScaledSizeWidth(100),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MySize.getScaledSizeHeight(5)),
                            color: Colors.red,
                          ),
                          child: Text("Reject",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.getScaledSizeHeight(20))),
                        ),
                      ),
                      Space.width(20),
                      InkWell(
                        onTap: () {
                          Get.back();

                          controller.leaveRejectAndApprove(
                              context: context,
                              operation: "verified",
                              id: leaveData.id!);
                        },
                        child: Container(
                          height: MySize.getScaledSizeHeight(40),
                          width: MySize.getScaledSizeWidth(100),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MySize.getScaledSizeHeight(5)),
                            color: Colors.green,
                          ),
                          child: Text("Approve",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.getScaledSizeHeight(20))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
