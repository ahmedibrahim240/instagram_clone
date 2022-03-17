import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: Get.put<EditProfileController>(EditProfileController()),
      builder: (EditProfileController controller) {
        return Scaffold(
          appBar: _appBar(controller),
          body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              PickUserImage(
                url: authControllers.getcurrentUser.image,
                isEditProfile: true,
              ),
              SizedBox(height: defaultSize * 2),
              EditProfileDataView(
                title: 'Name',
                textView: controller.getName,
              ),
              SizedBox(height: defaultSize * 2),
              EditProfileDataView(
                title: 'Username',
                textView: controller.getUserName,
              ),
              SizedBox(height: defaultSize * 2),
              EditProfileDataView(
                title: 'Bio',
                textView: controller.getBio,
              ),
            ],
          ),
        );
      },
    );
  }

  _appBar(EditProfileController controller) {
    return AppBar(
      title: const Text('Edit Profile'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          imagePickerConttroller.setData();
          editProfileController.setInitDate();
          Get.back();
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
      actions: [
        Obx(
          () => (editProfileController.getLoadedData)
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                  child: SizedBox(
                    height: 10,
                    width: 20,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : (!editProfileController.checkedIsAvailableToUpdate())
                  ? const Icon(
                      Icons.done,
                      color: kSecondaryColor,
                    ).paddingAll(10)
                  : IconButton(
                      onPressed: () {
                        editProfileController.loading();
                        editProfileController.updataProfileData();
                      },
                      icon: const Icon(
                        Icons.done,
                        color: kBlueColor,
                      ),
                    ),
        ),
      ],
    );
  }
}
