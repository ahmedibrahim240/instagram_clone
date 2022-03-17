import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens_export.dart';

class BuildImageGradView extends StatelessWidget {
  final PostController controller;
  const BuildImageGradView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.getSelectedModel.files == null ||
            controller.getSelectedModel.files!.isEmpty) {
          return Container();
        } else {
          return Expanded(
            child: GridView.builder(
              itemCount: controller.getSelectedModel.files!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (_, index) {
                var file = controller.getSelectedModel.files![index];
                return GestureDetector(
                  onDoubleTap: () {
                    if (controller.getIsMoreIamge) {
                      bool isRemave = controller.checkIsSelcetedImage(file);
                      if (isRemave) {
                        controller.addAndRemoveImage(
                          newImage: file,
                          isRemove: isRemave,
                        );
                      }
                    }
                  },
                  onTap: () {
                    controller.imageIndex.value = index;
                    controller.image.value = file;
                    if (controller.getIsMoreIamge) {
                      bool isRemave = controller.checkIsSelcetedImage(file);
                      if (!isRemave) {
                        controller.addAndRemoveImage(
                          newImage: file,
                          isRemove: isRemave,
                        );
                      }
                    }
                  },
                  child: Obx(
                    () => Stack(
                      children: [
                        bbuildImageView(file),
                        buildOpcityView(index, file),
                        if (controller.checkIsSelcetedImage(file))
                          slectedCountContaimer(file),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Opacity buildOpcityView(int index, String image) {
    return Opacity(
      opacity: getOacityNum(index, image),
      child: Container(
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  double getOacityNum(int index, String image) {
    if (controller.getIsMoreIamge) {
      if (controller.checkIsSelcetedImage(image)) {
        return 0.6;
      } else {
        return 0;
      }
    } else if (controller.imageIndex.value == index) {
      return 0.6;
    } else {
      return 0;
    }
  }

  bbuildImageView(String file) {
    return Image.file(
      File(file),
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  slectedCountContaimer(String file) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        height: 20,
        width: 20,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kBlueColor,
        ),
        child: Center(
          child: CustomText(
            text: "${controller.getSelectedImageLsit.indexOf(file) + 1}",
            fontSize: 10,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
