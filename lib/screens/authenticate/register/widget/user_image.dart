import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class PickUserImage extends StatelessWidget {
  final bool isEditProfile;
  final String? url;
  const PickUserImage({
    Key? key,
    this.isEditProfile = false,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerConttroller>(builder: (conttroller) {
      if (isEditProfile) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleImge(
              radius: 50,
              width: 100,
              height: 100,
              url: url,
              boxFit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () async {
                eidImageDialog('user-images', isUpdateImage: true);
              },
              child: const CustomText(
                text: 'Change profile photo',
                alignment: Alignment.center,
                color: kBlueColor,
              ),
            ),
          ],
        );
      } else {
        return _imageStack(conttroller);
      }
    });
  }

  _imageStack(ImagePickerConttroller conttroller) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          _viewImage(conttroller),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              iconSize: 40,
              onPressed: () {
                eidImageDialog('user-images');
              },
              icon: const Icon(
                Icons.add_a_photo,
                color: kBlueColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  _viewImage(ImagePickerConttroller conttroller, {bool isEditProfile = false}) {
    if (conttroller.imagefile.value == '') {
      return CircleAvatar(
        radius: isEditProfile ? 50 : 64,
        backgroundColor: kSecondaryColor,
        child: const Icon(
          Icons.person_outlined,
          size: 100,
          color: kPrimaryColor,
        ),
      );
    } else {
      return CircleAvatar(
        radius: isEditProfile ? 50 : 64,
        backgroundImage: FileImage(conttroller.imagefile.value),
        backgroundColor: kSecondaryColor,
      );
    }
  }
}
