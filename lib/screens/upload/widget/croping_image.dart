import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens_export.dart';
import 'package:crop_your_image/crop_your_image.dart';

class CroppingImage extends StatelessWidget {
  final PostController controller;
  static CropController cropController = CropController();
  const CroppingImage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.getImage.isEmpty) {
          return SizedBox(
            height: screenHeight * .45,
          );
        } else {
          return FutureBuilder(
            future: controller.uitnt8LsitImage(controller.getImage),
            builder: (_, AsyncSnapshot<Uint8List?> snap) {
              if (!snap.hasData) {
                return SizedBox(
                  height: screenHeight * .45,
                );
              } else if (snap.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: screenHeight * .45,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              } else {
                if (snap.data == null) {
                  return SizedBox(
                    height: screenHeight * .45,
                  );
                } else {
                  return SizedBox(
                    height: screenHeight * .5,
                    width: screenWidth,
                    child: Crop(
                      controller: cropController,
                      image: snap.data!,
                      aspectRatio: 4 / 3,
                      baseColor: Colors.transparent,
                      fixArea: true,
                      onCropped: (image) async {
                        routeController.routePage(
                          type: RouteType.To,
                          page: () => ImageFiltterEditing(
                            image: image,
                          ),
                        );
                      },
                      cornerDotBuilder: (size, edgeAlignment) =>
                          const SizedBox.shrink(),
                      interactive: true,
                      initialAreaBuilder: (rect) => rect,
                    ),
                  );
                }
              }
            },
          );
        }
      },
    );
  }
}
        // return SizedBox(
          //   height: screenHeight * .5,
          //   width: screenWidth,
          //   child: Crop(
          //     controller: cropController,
          //     image: controller.uitnt8LsitImage(controller.getImage),
          //     aspectRatio: 4 / 3,
          //     baseColor: Colors.transparent,
          //     fixArea: true,
          //     onCropped: (image) async {
          //       routeController.routePage(
          //         type: RouteType.To,
          //         page: () => ImageFiltterEditing(
          //           image: image,
          //         ),
          //       );
          //     },
          //     cornerDotBuilder: (size, edgeAlignment) =>
          //         const SizedBox.shrink(),
          //     interactive: true,
          //     initialAreaBuilder: (rect) => rect,
          //   ),
          // );
  