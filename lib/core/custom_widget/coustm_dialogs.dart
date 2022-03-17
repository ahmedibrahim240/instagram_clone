import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core_export.dart';

showLoading({String text = ' Loading...'}) {
  Get.defaultDialog(
    title: '',
    titleStyle: const TextStyle(fontSize: 0),
    backgroundColor: Colors.transparent,
    content: Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kMobileSearchColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation<Color>(
                kPrimaryColor,
              ),
            ),
          ),
          CustomText(
            text: text,
            fontSize: 12,
            color: kPrimaryColor,
            alignment: Alignment.center,
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

dismissLoadingWidget() {
  Get.back();
}

eidImageDialog(String name, {bool isUpdateImage = false}) {
  Get.defaultDialog(
    title: '',
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: const CustomText(text: "Pick from Gallery", fontSize: 20),
          leading: Icon(
            Icons.image,
            color: themeController.getPrimaryColor,
          ),
          onTap: () async {
            return await imagePickerConttroller.loadPicker(
              ImageSource.gallery,
              isUpdateImage: isUpdateImage,
            );
          },
        ),
        ListTile(
          title: const CustomText(text: "Take a pictuer", fontSize: 20),
          leading: Icon(
            Icons.camera,
            color: themeController.getPrimaryColor,
          ),
          onTap: () async {
            return await imagePickerConttroller.loadPicker(
              ImageSource.camera,
              isUpdateImage: isUpdateImage,
            );
          },
        )
      ],
    ),
    barrierDismissible: false,
    textCancel: "Cancel",
    cancelTextColor: themeController.getPrimaryColor,
    onCancel: () {
      Get.clearRouteTree();
    },
  );
}
