import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/models/models_export.dart';

import '../../../core/core_export.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set theme'),
        centerTitle: false,
      ),
      body: GetBuilder(
        init: Get.put<ThemeController>(ThemeController()),
        builder: (ThemeController controller) => ListView.separated(
          itemCount: themeRadioListTile.length,
          itemBuilder: (_, index) {
            ThemeModels themeModels = themeRadioListTile[index];
            return Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.grey.shade400,
              ),
              child: RadioListTile(
                value: themeModels.index,
                groupValue: controller.getGroupValue,
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: kBlueColor,
                dense: false,
                title: CustomText(
                  text: themeModels.title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (int? value) {
                  controller.groupValue.value = value!;
                  controller.onChangedThemeMode();
                },
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
