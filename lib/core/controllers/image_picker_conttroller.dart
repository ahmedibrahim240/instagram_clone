import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/core_export.dart';
import 'package:path/path.dart';

import '../../models/user.dart';

class ImagePickerConttroller extends GetxController {
  static ImagePickerConttroller instance = Get.find();
  final picker = ImagePicker();
  final String userChildName = 'profilePics';
  final String postChildName = 'postPics';
  Rx<dynamic> imagefile = Rx<dynamic>('');
  @override
  void onReady() {
    super.onReady();
    imagefile.value = '';
  }

  setData() {
    imagefile.value = '';
  }

  loadPicker(ImageSource source, {bool isUpdateImage = false}) async {
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      if (isUpdateImage) {
        return picked;
      } else {
        _cropImage(picked, isUpdateImage);
      }
    }
    Get.back();
  }

  _cropImage(var picked, bool isUpdateImage) async {
    var cropped = await ImageCropper().cropImage(
      androidUiSettings: const AndroidUiSettings(
        statusBarColor: kBlueColor,
        toolbarColor: kBlueColor,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      if (!isUpdateImage) {
        imagefile.value = cropped;
      } else {
        imagefile.value = cropped;

        showLoading();
        await uploadImage(
          userChildName,
          authControllers.getcurrentUser.id!,
          updateuserImage: true,
        ).then(
          (userImage) async {
            await authControllers.updateUserData(
              {Usermodels.IMAGE: userImage},
            );
            dismissLoadingWidget();
            Get.back();
          },
        );
      }
    }
    update();
  }

  Future<String> uploadImage(
    String childName,
    String uuid, {
    bool isPost = false,
    bool updateuserImage = false,
    String? postId,
  }) async {
    try {
      String fileName = basename(imagefile.value.path);
      late Reference ref;
      ref = storage.ref().child(childName).child(uuid).child(fileName);
      if (updateuserImage) {
        Reference refDelate = FirebaseStorage.instance.refFromURL(
          authControllers.getcurrentUser.image!,
        );
        await refDelate.delete();
      } else {
        if (isPost) {
          ref = ref.child(postId!);
        }
      }

      UploadTask uploadTask = ref.putFile(imagefile.value);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (error) {
      customErrorSnakBar(error: error.message.toString());
      return '';
    }
  }
}
