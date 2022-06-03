import 'package:argon_admin/app/constants/api_constant.dart';
import 'package:argon_admin/app/constants/color_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/main.dart';
import 'package:argon_admin/utilities/text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/all_users_data_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_screen_controller.dart';

class DashboardScreenView extends GetWidget<DashboardScreenController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          decoration: const BoxDecoration(color: Color(0xff01a7fe)),
          child: Row(
            children: [
              Container(
                color: (ResponsiveWidget.isMediumScreen(context))
                    ? Colors.transparent
                    : Color(0xff01a7fe),
                child: Padding(
                  padding: Spacing.only(left: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space.height(55),
                      Container(
                          height: MySize.getScaledSizeHeight(65),
                          child: const Image(
                            image: AssetImage("assets/Logo2.png"),
                            fit: BoxFit.contain,
                          )),
                      Space.height(80),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: MySize.getScaledSizeHeight(30),
                              width: MySize.getScaledSizeWidth(30),
                              child: const Image(
                                image: AssetImage("assets/ic_dashboard.png"),
                                fit: BoxFit.contain,
                              )),
                          Space.width(20),
                          Text(
                            "Dashboard",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MySize.getScaledSizeHeight(20)),
                          ),
                        ],
                      ),
                      Space.height(30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: MySize.getScaledSizeHeight(30),
                              width: MySize.getScaledSizeWidth(30),
                              child: const Image(
                                image: AssetImage("assets/ic_leave.png"),
                                fit: BoxFit.contain,
                              )),
                          Space.width(20),
                          Text(
                            "Leave",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MySize.getScaledSizeHeight(20)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xff01a7fe)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MySize.getScaledSizeHeight(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: MySize.getScaledSizeHeight(27),
                              width: MySize.getScaledSizeWidth(27),
                              child: Stack(
                                children: [
                                  Image(
                                    image: AssetImage("assets/ic_noti.png"),
                                  ),
                                  Positioned(
                                    right: MySize.getScaledSizeWidth(4),
                                    top: 0,
                                    child: Container(
                                        height: MySize.getScaledSizeHeight(8),
                                        width: MySize.getScaledSizeWidth(8),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10000))),
                                  ),
                                ],
                              ),
                            ),
                            Space.width(25),
                            ClipRRect(
                              child: Container(
                                child: getImageByLink(
                                  boxFit: BoxFit.cover,
                                  url: "",
                                  height: 50,
                                  width: 50,
                                ),
                                height: MySize.getScaledSizeHeight(
                                    MySize.getScaledSizeHeight(50)),
                                width: MySize.getScaledSizeWidth(50),
                              ),
                              borderRadius: BorderRadius.circular(
                                  MySize.getScaledSizeHeight(1000)),
                            ),
                            Space.width(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "HR admin panel",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "HR Manager",
                                  style: TextStyle(
                                      fontSize: MySize.getScaledSizeHeight(14),
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            Space.width(10),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: MySize.getScaledSizeHeight(30),
                              color: Colors.white,
                            ),
                            Space.width(100),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: MySize.getScaledSizeHeight(45),
                                color: const Color(0xff01a7fe),
                                margin: EdgeInsets.only(
                                    top: MySize.getScaledSizeHeight(90)),
                                child: const Image(
                                  image: AssetImage("assets/Rectangle 4.png"),
                                )),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      // height: MySize.getScaledSizeHeight(800),

                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                MySize.getScaledSizeHeight(
                                                    75))),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          getTopSection(context: context),
                                          Space.height(30),
                                          Expanded(
                                            child: (controller.hasData.isFalse)
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          appTheme.primaryTheme,
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: Spacing.only(
                                                        left: 70, right: 100),
                                                    child: GridView.builder(
                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                            childAspectRatio: MySize
                                                                .getScaledSizeHeight(
                                                                    2),
                                                            mainAxisExtent: MySize
                                                                .getScaledSizeHeight(
                                                                    155),
                                                            crossAxisSpacing: MySize
                                                                .getScaledSizeWidth(
                                                                    25),
                                                            mainAxisSpacing: MySize
                                                                .getScaledSizeHeight(
                                                                    25),
                                                            crossAxisCount: 4),
                                                        itemCount: controller
                                                            .usersList.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .circular(MySize
                                                                        .getScaledSizeHeight(
                                                                            40))),
                                                            padding: Spacing
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        20),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    InkWell(
                                                                      child:
                                                                          ClipRRect(
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              getImageByLink(
                                                                            boxFit:
                                                                                BoxFit.cover,
                                                                            url:
                                                                                imageUrl + controller.usersList[index].img!,
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                50,
                                                                          ),
                                                                          height:
                                                                              MySize.getScaledSizeHeight(MySize.getScaledSizeHeight(70)),
                                                                          width:
                                                                              MySize.getScaledSizeWidth(70),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(MySize.getScaledSizeHeight(1000)),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        openImageDialog(
                                                                            context:
                                                                                context,
                                                                            imageLink:
                                                                                imageUrl + controller.usersList[index].img!);
                                                                      },
                                                                    ),
                                                                    Space.width(
                                                                        20),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "${controller.usersList[index].name![0].toUpperCase()}${controller.usersList[index].name!.substring(1)}",
                                                                          style: TextStyle(
                                                                              fontSize: MySize.getScaledSizeHeight(18),
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                        Space.height(
                                                                            10),
                                                                        Text(
                                                                          controller
                                                                              .usersList[index]
                                                                              .role!
                                                                              .toUpperCase(),
                                                                          style: TextStyle(
                                                                              fontSize: MySize.getScaledSizeHeight(13),
                                                                              color: Color(0xff626262),
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                        Space.height(
                                                                            10),
                                                                        Text(
                                                                          controller
                                                                              .usersList[index]
                                                                              .mobile!
                                                                              .toUpperCase(),
                                                                          style: TextStyle(
                                                                              fontSize: MySize.getScaledSizeHeight(13),
                                                                              color: Color(0xff626262),
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                        Space.height(
                                                                            10),
                                                                        Row(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                box.write(ArgumentConstant.userEmailForEdit, controller.usersList[index].email);
                                                                                box.write(ArgumentConstant.isForEdit, true);
                                                                                Get.toNamed(Routes.CREATE_USER_SCREEN);
                                                                              },
                                                                              child: Container(
                                                                                height: MySize.getScaledSizeHeight(30),
                                                                                width: MySize.getScaledSizeWidth(80),
                                                                                decoration: BoxDecoration(color: Color(0xfff3fbff), borderRadius: BorderRadius.circular(MySize.getScaledSizeHeight(5))),
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "Edit",
                                                                                  style: TextStyle(color: appTheme.primaryTheme),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Space.width(20),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                deleteUserDialog(context: context, user: controller.usersList[index]);
                                                                              },
                                                                              child: Container(
                                                                                height: MySize.getScaledSizeHeight(30),
                                                                                width: MySize.getScaledSizeWidth(80),
                                                                                decoration: BoxDecoration(color: Color(0xfffff8f8), borderRadius: BorderRadius.circular(MySize.getScaledSizeHeight(5))),
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "Delete",
                                                                                  style: TextStyle(color: Colors.red),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget getTopSection({required BuildContext context}) {
    return Padding(
      padding: Spacing.only(
          left: MySize.getScaledSizeWidth(80), top: 35, right: 100),
      child: Row(
        children: [
          Text(
            "Dashboard",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: MySize.getScaledSizeHeight(30)),
          ),
          Spacer(),
          Container(
            height: MySize.getScaledSizeHeight(40),
            width: MySize.getScaledSizeWidth(280),
            child: getTextField(
              textEditingController: controller.searchController,
              isFillColor: true,
              borderColor: Colors.white,
              fillColor: Colors.white,
              hintText: "Search...",
              prefixIcon: Padding(
                padding: Spacing.all(10),
                child: Image(image: AssetImage("assets/ic_serch.png")),
              ),
              onChanged: (val) {
                controller.getFilterData(name: val.toLowerCase().trim());
              },
              suffixIcon: InkWell(
                  onTap: () {
                    controller.searchController.clear();
                    controller.isSearchOn.value = false;
                    controller.getFilterData(name: "");
                    FocusScope.of(context).unfocus();
                  },
                  child: Icon(Icons.close)),
            ),
          ),
          Space.width(35),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.CREATE_USER_SCREEN);
            },
            child: Container(
              height: MySize.getScaledSizeHeight(40),
              width: MySize.getScaledSizeWidth(125),
              padding: Spacing.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(MySize.getScaledSizeHeight(10)),
                  color: appTheme.primaryTheme),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MySize.getScaledSizeHeight(25),
                    width: MySize.getScaledSizeWidth(25),
                    child: Image(image: AssetImage("assets/ic_add.png")),
                  ),
                  Space.width(8),
                  Text(
                    "New Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: MySize.getScaledSizeHeight(17)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(MySize.getScaledSizeHeight(15))),
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
