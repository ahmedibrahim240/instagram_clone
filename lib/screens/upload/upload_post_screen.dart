import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens_export.dart';

class UploadPostScrean extends StatelessWidget {
  const UploadPostScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: CustomRefreshWidget(
        child: Scaffold(
          appBar: uploadPostAppBar(),
          body: GetBuilder(
            init: Get.put<PostController>(PostController()),
            builder: (PostController controller) {
              return Column(
                children: [
                  CroppingImage(controller: controller),
                  buildRowButtomsView(
                    controller,
                  ),
                  BuildImageGradView(controller: controller),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
