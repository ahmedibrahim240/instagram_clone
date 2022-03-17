import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../screens_export.dart';

class EditDataForm extends StatelessWidget {
  final String title, initData;
  final bool isUserName, isBio;
  const EditDataForm({
    Key? key,
    required this.title,
    required this.initData,
    required this.isUserName,
    required this.isBio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textEditController =
        TextEditingController(text: initData);
    return Scaffold(
      appBar: _appBar(formKey),
      body: GetBuilder<EditProfileController>(
        init: Get.put<EditProfileController>(EditProfileController()),
        builder: (EditProfileController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: formKey,
              child: TextFormField(
                autofocus: true,
                controller: textEditController,
                onChanged: (value) {
                  if (isUserName) {
                    controller.userName.value = textEditController.text.trim();
                  } else {
                    if (isBio) {
                      controller.bio.value = textEditController.text.trim();
                    } else {
                      controller.name.value = textEditController.text.trim();
                    }
                  }
                },
                onSaved: (value) {
                  if (value != initData) {
                    if (isUserName) {
                      if (controller.isExistUserName.value &&
                          controller.isFormatUserName.value) {
                        customErrorSnakBar(
                          error: 'Username is badly formatted or is Exist..\n'
                              "plese chose anther username",
                        );
                      } else {
                        controller.bio.value = textEditController.text.trim();
                      }
                    } else {
                      if (isBio) {
                        controller.bio.value = textEditController.text.trim();
                      } else {
                        controller.name.value = textEditController.text.trim();
                      }
                    }
                  } else {
                    controller.setInitDate();
                  }
                },
                validator: (vale) => isBio
                    ? null
                    : vale!.isEmpty
                        ? "Data Required "
                        : null,
                maxLines: isBio ? null : 1,
                decoration: isUserName
                    ? InputDecoration(
                        suffixIcon: CustomSuffixIcon(
                        initData: initData,
                      ))
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  _appBar(GlobalKey<FormState> formKey) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        onPressed: () {
          editProfileController.setInitDate();
          Get.back();
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
      actions: [
        Obx(
          () {
            if (editProfileController.getLoadedData) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                  ),
                ),
              );
            } else {
              return (!editProfileController.checkedIsAvailableToUpdate())
                  ? const Icon(
                      Icons.done,
                      color: kSecondaryColor,
                    ).paddingAll(10)
                  : IconButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          editProfileController.loading();

                          formKey.currentState!.save();
                          await Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              editProfileController.loading();
                              Get.back();
                            },
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.done,
                        color: kBlueColor,
                      ),
                    );
            }
          },
        ),
      ],
    );
  }
}
