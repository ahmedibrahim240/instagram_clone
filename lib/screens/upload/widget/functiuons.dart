import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/models_export.dart';
import '../../screens_export.dart';

uploadPostAppBar() {
  return AppBar(
    title: const Text('New Post'),
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.close,
      ),
    ),
    actions: [
      Transform.rotate(
        angle: 180 * math.pi / 180,
        child: IconButton(
          onPressed: () {
            // showLoading(text: ' Load image..');
            CroppingImage.cropController.crop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kBlueColor,
          ),
        ),
      ),
    ],
  );
}

buidDropDownSheet(PostController controller) {
  return Get.bottomSheet(
    Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 40,
      ),
      child: Wrap(
        children: [
          Center(
            child: SizedBox(
              width: 40,
              child: Divider(
                color: Colors.grey.shade400,
                thickness: 2,
              ),
            ),
          ),
          Wrap(
            children: postController.getFilesList!
                .map(
                  (FileModel fileModel) => GetBuilder(
                    builder: (PostController controller) => TextButton(
                      onPressed: () {
                        controller.selectedModel.value = fileModel;
                        controller.imageIndex.value = 0;

                        controller.image.value = fileModel.files![0];
                        Get.back();
                      },
                      child: CustomText(
                        text: fileModel.folder!,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
    backgroundColor:
        themeController.darkMode.value ? kMobileSearchColor : kPrimaryColor,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}

buildRowButtomsView(PostController controller) {
  return Obx(
    () => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => buidDropDownSheet(controller),
            child: Row(
              children: [
                CustomText(
                  text: controller.getSelectedModel.folder ?? "",
                  fontSize: 14,
                  color: themeController.getPrimaryColor,
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                ),
              ],
            ),
          ),
          Row(
            children: [
              CustomCircleIconBouttom(
                onTap: () {
                  controller.selectedMoreImage();
                },
                bgColor: controller.getIsMoreIamge ? kBlueColor : null,
                icon: Icons.photo_library_outlined,
              ),
              const SizedBox(width: 5),
              CustomCircleIconBouttom(
                onTap: () async {
                  var file = await imagePickerConttroller.loadPicker(
                    ImageSource.camera,
                    isUpdateImage: true,
                  );
                  if (file != null) {
                    controller.imageIndex.value = 99909;

                    controller.image.value = file.path;
                  }
                },
                icon: Icons.camera_alt_outlined,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
