import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/color_constant.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetWidget<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: controller.formKey,
          child: Row(
            children: [
              if (ResponsiveWidget.isLargeScreen(context))
                Image(
                  image: AssetImage("assets/login_pic.png"),
                ),
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOG IN",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MySize.size50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Space.height(5),
                        Text(
                          "Please enter your mail and password to continue",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MySize.size25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Space.height(45),
                        Container(
                          padding: EdgeInsets.only(
                            top: MySize.getScaledSizeHeight(20),
                          ),
                          width: MySize.getScaledSizeWidth(550),
                          child: getTextField(
                            textEditingController:
                                controller.emailController.value,
                            borderRadius: MySize.size20,
                            hintText: "Username",
                            validator: (input) => !isNullEmptyOrFalse(input)
                                ? null
                                : "Check your email",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(MySize.size15!),
                              child: Image(
                                image: AssetImage("assets/ic_mail.png"),
                                height: MySize.size25,
                                width: MySize.size25,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.only(
                              top: MySize.getScaledSizeHeight(20),
                            ),
                            width: MySize.getScaledSizeWidth(550),
                            child: getTextField(
                              textEditingController:
                                  controller.passController.value,
                              //size: MySize.size70,
                              borderRadius: MySize.size20,

                              hintText: "Password",
                              validator: (input) => !isNullEmptyOrFalse(input)
                                  ? null
                                  : "Please Enter Password",
                              textVisible: controller.passwordVisible.value,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(MySize.size15!),
                                child: Image(
                                  image: AssetImage("assets/ic_lock.png"),
                                  height: MySize.size25,
                                  width: MySize.size25,
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.passwordVisible.toggle();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(MySize.size15!),
                                  child: Image(
                                    image: AssetImage(
                                        (!controller.passwordVisible.value)
                                            ? "assets/ic_eye_offf.png"
                                            : "assets/ic_eye.png"),
                                    height: MySize.size25,
                                    width: MySize.size30,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        Container(
                          //width: MySize.getScaledSizeWidth(550),
                          padding: EdgeInsets.only(
                            top: MySize.getScaledSizeHeight(40),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.getSingleUserData(context: context);
                              }
                            },
                            child: button(
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontsize: MySize.size23,
                              radius: MySize.size20!,
                              width: MySize.getScaledSizeWidth(220),
                              fontWeight: FontWeight.w700,
                              title: "LOG IN",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

Container button({
  double height = 50,
  double width = 341,
  String? title = "",
  Color? backgroundColor,
  Color? borderColor,
  Color? textColor,
  double radius = 8,
  Widget? widget,
  FontWeight fontWeight = FontWeight.bold,
  double? fontsize = 14,
}) {
  return Container(
    height: MySize.getScaledSizeHeight(height),
    width: MySize.getScaledSizeWidth(width),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: 1),
      color:
          (backgroundColor == null) ? appTheme.primaryTheme : backgroundColor,
    ),
    alignment: Alignment.center,
    child: (widget != null)
        ? Center(child: widget)
        : Text(
            title!,
            style: TextStyle(
                color: (textColor == null) ? Colors.white : textColor,
                fontWeight: fontWeight,
                fontSize: MySize.getScaledSizeHeight(fontsize!)),
          ),
  );
}
