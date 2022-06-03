import 'package:argon_admin/app/constants/api_constant.dart';
import 'package:argon_admin/app/constants/color_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../models/all_users_data_model.dart';
import '../controllers/all_user_list_controller.dart';

class AllUserListView extends GetWidget<AllUserListController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
            centerTitle: true,
            leading: Text(""),
            actions: [
              (controller.isSearchOn.isTrue)
                  ? Container(
                      width: MySize.getScaledSizeWidth(500),
                      padding:
                          EdgeInsets.only(right: MySize.getScaledSizeWidth(50)),
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: controller.searchController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          suffix: InkWell(
                              onTap: () {
                                controller.searchController.clear();
                                controller.isSearchOn.value = false;
                                controller.getFilterData(name: "");
                              },
                              child: Icon(Icons.close)),
                        ),
                        style: TextStyle(color: Colors.white),
                        onChanged: (val) {
                          controller.getFilterData(
                              name: val.toLowerCase().trim());
                        },
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.only(right: MySize.getScaledSizeWidth(20)),
                      child: InkWell(
                        onTap: () {
                          controller.isSearchOn.value = true;
                        },
                        child: Icon(Icons.search,
                            size: MySize.getScaledSizeHeight(30)),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(right: MySize.getScaledSizeWidth(30)),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.CREATE_USER_SCREEN);
                  },
                  child: Icon(Icons.add,
                      color: Colors.white,
                      size: MySize.getScaledSizeHeight(30)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: MySize.getScaledSizeWidth(30)),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.LEAVE_SCREEN);
                  },
                  child: Center(
                      child: Text(
                    "Leave",
                    style: TextStyle(fontSize: MySize.getScaledSizeHeight(18)),
                  )),
                ),
              ),
            ],
          ),
          body: (controller.hasData.isFalse)
              ? Center(
                  child:
                      CircularProgressIndicator(color: appTheme.primaryTheme),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MySize.getScaledSizeWidth(20),
                      vertical: MySize.getScaledSizeHeight(20)),
                  child: Column(
                    children: [
                      Expanded(
                          child: (isNullEmptyOrFalse(controller.usersList))
                              ? Center(
                                  child: Text(
                                    "User not found.",
                                    style: TextStyle(
                                        fontSize:
                                            MySize.getScaledSizeHeight(20)),
                                  ),
                                )
                              : Wrap(
                                  spacing: MySize.getScaledSizeWidth(10),
                                  runSpacing: MySize.getScaledSizeHeight(10),
                                  children: List.generate(
                                      controller.usersList.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        box.write(
                                            ArgumentConstant.userEmailForDetail,
                                            controller.usersList[index].email);
                                        Get.toNamed(Routes.DETAIL_SCREEN);
                                      },
                                      child: Container(
                                        height: MySize.getScaledSizeHeight(300),
                                        width: MySize.getScaledSizeWidth(300),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: appTheme.primaryTheme,
                                              width: MySize.getScaledSizeHeight(
                                                  2)),
                                          borderRadius: BorderRadius.circular(
                                            MySize.getScaledSizeHeight(5),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: MySize.getScaledSizeHeight(10),
                                            left: MySize.getScaledSizeWidth(10),
                                            right:
                                                MySize.getScaledSizeWidth(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height:
                                                  MySize.getScaledSizeHeight(
                                                      MySize
                                                          .getScaledSizeHeight(
                                                              100)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: MySize
                                                        .getScaledSizeWidth(5),
                                                    top: MySize
                                                        .getScaledSizeHeight(2),
                                                    child: InkWell(
                                                      onTap: () {
                                                        deleteUserDialog(
                                                            context: context,
                                                            user: controller
                                                                    .usersList[
                                                                index]);
                                                      },
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: MySize
                                                                .getScaledSizeHeight(
                                                                    17)),
                                                      ),
                                                      focusColor: Colors.blue,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () {
                                                        openImageDialog(
                                                            context: context,
                                                            imageLink: imageUrl +
                                                                controller
                                                                    .usersList[
                                                                        index]
                                                                    .img!);
                                                      },
                                                      child: ClipRRect(
                                                        child: Container(
                                                          child: getImageByLink(
                                                            boxFit:
                                                                BoxFit.cover,
                                                            url: imageUrl +
                                                                controller
                                                                    .usersList[
                                                                        index]
                                                                    .img!,
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                          height: MySize
                                                              .getScaledSizeHeight(
                                                                  MySize
                                                                      .getScaledSizeHeight(
                                                                          100)),
                                                          width: MySize
                                                              .getScaledSizeWidth(
                                                                  100),
                                                        ),
                                                        borderRadius: BorderRadius
                                                            .circular(MySize
                                                                .getScaledSizeHeight(
                                                                    1000)),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: MySize
                                                        .getScaledSizeWidth(5),
                                                    top: MySize
                                                        .getScaledSizeHeight(2),
                                                    child: InkWell(
                                                      onTap: () {
                                                        box.write(
                                                            ArgumentConstant
                                                                .userEmailForEdit,
                                                            controller
                                                                .usersList[
                                                                    index]
                                                                .email);
                                                        box.write(
                                                            ArgumentConstant
                                                                .isForEdit,
                                                            true);
                                                        Get.toNamed(Routes
                                                            .CREATE_USER_SCREEN);
                                                      },
                                                      child: Text(
                                                        "Edit",
                                                        style: TextStyle(
                                                            fontSize: MySize
                                                                .getScaledSizeHeight(
                                                                    17)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    MySize.getScaledSizeHeight(
                                                        5)),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${controller.usersList[index].name![0].toUpperCase()}${controller.usersList[index].name!.substring(1)}",
                                                    style: TextStyle(
                                                        fontSize: MySize
                                                            .getScaledSizeHeight(
                                                                15))),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].gender!),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].role!),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].email!),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].mobile!),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].date!),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].salary!),
                                                SizedBox(
                                                    height: MySize
                                                        .getScaledSizeWidth(5)),
                                                Text(controller
                                                    .usersList[index].adr!),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                )),
                    ],
                  )));
    });
  }

  openImageDialog({required BuildContext context, required String imageLink}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MySize.getScaledSizeHeight(400),
              width: MySize.getScaledSizeWidth(400),
              child: getImageByLink(url: imageLink, height: 400, width: 400),
            ),
          );
        });
  }

  deleteUserDialog({required BuildContext context, required User user}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Are you sure to delete this user",
                  style: TextStyle(),
                ),
                SizedBox(height: MySize.getScaledSizeHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          height: MySize.getScaledSizeHeight(40),
                          width: MySize.getScaledSizeWidth(100),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(
                                  MySize.getScaledSizeHeight(10))),
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(width: MySize.getScaledSizeWidth(20)),
                    InkWell(
                      onTap: () {
                        Get.back();
                        controller.deleteUser(
                            context: context, email: user.email!);
                      },
                      child: Container(
                          height: MySize.getScaledSizeHeight(40),
                          width: MySize.getScaledSizeWidth(100),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(
                                  MySize.getScaledSizeHeight(10))),
                          alignment: Alignment.center,
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ]),
            ),
          );
        });
  }
}
