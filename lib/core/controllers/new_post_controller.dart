import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/models_export.dart';
import 'package:storage_path/storage_path.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();
  Rx<List<FileModel>?> filesList = Rx<List<FileModel>>([]);
  Rx<FileModel> selectedModel = Rx<FileModel>(FileModel());
  RxString image = ''.obs;
  Rx<List<String>> selectedImageLsit = Rx<List<String>>([]);
  RxInt imageIndex = 0.obs;
  RxBool loadData = false.obs;
  RxBool isMoreImage = false.obs;
  List<FileModel>? get getFilesList => filesList.value;
  List<String> get getSelectedImageLsit => selectedImageLsit.value;
  FileModel get getSelectedModel => selectedModel.value;
  String get getImage => image.value;
  int get getImageIndex => imageIndex.value;
  bool get getIsMoreIamge => isMoreImage.value;

  @override
  onInit() async {
    super.onInit();
    _setInitData();

    await getImagesPasth();
  }

  _setInitData() {
    imageIndex.value = 0;

    isMoreImage.value = false;
    selectedImageLsit.value = [];
  }

  getImagesPasth() async {
    await StoragePath.imagesPath.then(
      (value) {
        var images = jsonDecode(value!) as List;
        filesList.value =
            images.map<FileModel>((e) => FileModel.fromJson(e)).toList();

        selectedModel.value = getFilesList![0];
        image.value = getFilesList![0].files![0];
      },
    );
    update();
  }

  selectedMoreImage() {
    isMoreImage.value = !isMoreImage.value;
    if (getIsMoreIamge == false) {
      _setInitData();
    } else {
      selectedImageLsit.value.add(getImage);
    }
    update();
  }

  addAndRemoveImage({required String newImage, required bool isRemove}) {
    List<String> newList = [];
    if (!isRemove) {
      if (selectedImageLsit.value.isEmpty) {
        newList.add(newImage);
      } else {
        for (String oldImage in getSelectedImageLsit) {
          newList.add(oldImage);
        }
        newList.add(newImage);
      }
      selectedImageLsit.value = [];
      selectedImageLsit.value = newList;
    } else {
      if (getSelectedImageLsit.length == 1) {
        selectedImageLsit.value = [];
        image.value = newImage;

        isMoreImage.value = false;
        return;
      } else {
        for (String oldImage in getSelectedImageLsit) {
          if (oldImage != newImage) {
            newList.add(oldImage);
          }
        }
        selectedImageLsit.value = [];
        selectedImageLsit.value = newList;
      }
    }
    update();
  }

  bool checkIsSelcetedImage(String image) {
    return getSelectedImageLsit.where((element) => image == element).isNotEmpty;
  }

  Future<Uint8List?> uitnt8LsitImage(String image) async {
    try {
      File file = File(image);

      return await file.readAsBytes();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
