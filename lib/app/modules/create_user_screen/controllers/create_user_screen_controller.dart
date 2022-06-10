import 'dart:convert';
import 'dart:typed_data';
import 'package:argon_admin/app/constants/api_constant.dart';
import 'package:argon_admin/app/constants/sizeConstant.dart';
import 'package:argon_admin/app/data/NetworkClient.dart';
import 'package:argon_admin/app/models/all_users_data_model.dart';
import 'package:argon_admin/app/modules/all_user_list/controllers/all_user_list_controller.dart';
import 'package:argon_admin/app/routes/app_pages.dart';
import 'package:argon_admin/utilities/custome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import '../../../../main.dart';

class CreateUserScreenController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString selectGender = "Male".obs;
  RxString selectedDate = "Select joining date".obs;
  Rx<XFile>? image;
  RxString selectedImagePath = "".obs;
  final ImagePicker picker = ImagePicker();
  RxBool isImagePicked = false.obs;
  RxString role = "select role".obs;
  DateTime dateTime = DateTime.now();
  RxBool isForEdit = false.obs;
  RxBool hasData = true.obs;
  AllUserListController? allUserListController;
  User? user;
  RxString imageFromServer = "".obs;
  RxList roleList = [
    "Flutter Developer",
    "Unity Developer",
    "Android Developer",
    "Web Developer"
  ].obs;
  @override
  void onInit() {
    Get.lazyPut<AllUserListController>(
      () => AllUserListController(),
    );
    allUserListController = Get.find<AllUserListController>();
    selectedDate.value = "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    print("Testing:= ${box.read(ArgumentConstant.userEmailForEdit)}");
    if (box.read(ArgumentConstant.isForEdit) != null &&
        box.read(ArgumentConstant.userEmailForEdit) != null) {
      isForEdit.value = box.read(ArgumentConstant.isForEdit);
      if (isForEdit.value == true) {
        emailController.text = box.read(ArgumentConstant.userEmailForEdit);
      }
    }
    if (isForEdit.value == true) {
      getSingleUserData(context: Get.context!);
    }
    super.onInit();
  }

  @override
  void dispose() {
    clearController();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  clearController() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    salaryController.dispose();
    passwordController.dispose();
    addressController.dispose();
  }

  getSubmitApi({required BuildContext context}) async {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    String fileName = "";
    List<int>? imageData;
    if (!isNullEmptyOrFalse(image)) {
      fileName = p.basenameWithoutExtension(image!.value.path);
      Uint8List bytes = await image!.value.readAsBytes();
      imageData = bytes.cast();
    } else {
      fileName = "";
    }

    Map<String, dynamic> dict = {};
    dict["name"] = firstNameController.text.trim();
    dict["email"] = emailController.text.trim();
    dict["mobile"] = mobileNumberController.text.trim();
    dict["address"] = addressController.text.trim();
    dict["gender"] = selectGender.value;
    dict["role"] = role.value;
    dict["salary"] = salaryController.text.trim();
    dict["pass"] = passwordController.text.trim();
    dict["joining"] = selectedDate.value;
    dict["image"] = (!isNullEmptyOrFalse(image))
        ? await MultipartFile.fromBytes(
            imageData!,
            filename: "f$fileName.jpg",
          )
        : "";
    FormData formData = FormData.fromMap(dict);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.createUser,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        // String res = response.toString();
        // res = res.substring(1);
        Map<String, dynamic> data = jsonDecode(response);

        if (data["status"] == 0) {
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        } else {
          app
              .resolve<CustomDialogs>()
              .getDialog(title: "Failed", desc: data["msg"]);
        }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  getSingleUserData({required BuildContext context}) async {
    hasData.value = false;
    Map<String, dynamic> dict = {};

    dict["email"] = emailController.text.trim();
    FormData formData = FormData.fromMap(dict);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.getSingleUser,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (response, message) {
        hasData.value = true;
        user = User.fromJson(response["data"]);
        firstNameController.text = user!.name!;
        lastNameController.text = "NA";
        emailController.text = user!.email!;
        selectGender.value = user!.gender!;
        addressController.text = user!.adr!;
        role.value = user!.role!;
        mobileNumberController.text = user!.mobile!;
        salaryController.text = user!.salary!;
        passwordController.text = user!.pass!;
        imageFromServer.value = user!.img!;
        selectedDate.value = user!.joining!;
      },
      failureCallback: (status, message) {
        hasData.value = true;
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }

  updateUser({required BuildContext context}) async {
    app.resolve<CustomDialogs>().showCircularDialog(context);
    String fileName = "";
    List<int>? imageData;
    if (!isNullEmptyOrFalse(image)) {
      fileName = p.basenameWithoutExtension(image!.value.path);
      Uint8List bytes = await image!.value.readAsBytes();
      imageData = bytes.cast();
    } else {
      fileName = "";
    }

    Map<String, dynamic> dict = {};
    dict["name"] = firstNameController.text.trim();
    dict["email"] = emailController.text.trim();
    dict["mobile"] = mobileNumberController.text.trim();
    dict["address"] = addressController.text.trim();
    dict["gender"] = selectGender.value;
    dict["role"] = role.value;
    dict["salary"] = salaryController.text.trim();
    dict["pass"] = passwordController.text.trim();
    dict["joining"] = selectedDate.value;
    dict["image"] = (!isNullEmptyOrFalse(image))
        ? await MultipartFile.fromBytes(
            imageData!,
            filename: "f$fileName.jpg",
          )
        : "${imageFromServer.value}";
    FormData formData = FormData.fromMap(dict);

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.updateUser,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (response, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);

        box.write(ArgumentConstant.isForEdit, false);
        // Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        allUserListController!.getAllUsers(context: context);
        Get.back();
        // String res = response.toString();
        // res = res.substring(0);
        // Map<String, dynamic> data = jsonDecode(res);
        // print("RESS:= $res");
        // if (data["status"] == 0) {
        //   clearController();
        //   Get.back();
        // } else {
        //   app
        //       .resolve<CustomDialogs>()
        //       .getDialog(title: "Failed", desc: data["msg"]);
        // }
      },
      failureCallback: (status, message) {
        app.resolve<CustomDialogs>().hideCircularDialog(context);
        app
            .resolve<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");
        print(" error");
      },
    );
  }
}
