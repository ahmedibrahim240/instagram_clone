import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return GetX(
      init: Get.put<SearchController>(SearchController()),
      builder: (SearchController controller) => Scaffold(
        appBar: _searchAppBar(
          textEditingController,
          controller,
          context,
        ),
        body: CustomRefreshWidget(
          child: (controller.searshText.value.isEmpty)
              ? const BuildSearchPosts()
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SearchBodyView(
                    controller: controller,
                  ),
                ),
        ),
      ),
    );
  }

  _searchAppBar(
    TextEditingController textEditingController,
    SearchController controller,
    BuildContext context,
  ) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 35,
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kSecondaryColor),
                color: !themeController.darkMode.value
                    ? Colors.transparent
                    : kMobileBackgroundColor,
              ),
              child: Center(
                child: TextFormField(
                  scrollPadding: EdgeInsets.zero,
                  controller: textEditingController,
                  onChanged: (vale) => searchController.searshText.value =
                      textEditingController.text,
                  onEditingComplete: () {
                    if (controller.isNotData.value) {
                      textEditingController.clear();
                      controller.searshText.value = '';
                    }
                    FocusScope.of(context).unfocus();
                    return;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search ',
                    helperStyle: const TextStyle(fontSize: 5),
                    border: InputBorder.none,
                    prefixIcon: (controller.searshText.value.isEmpty)
                        ? Icon(
                            Icons.search,
                            color: themeController.getPrimaryColor,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          if (controller.searshText.value.isNotEmpty)
            IconButton(
              onPressed: () {
                textEditingController.clear();

                controller.searshText.value = '';
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(
                Icons.close,
                color: kBlueColor,
              ),
            ),
        ],
      ),
    );
  }
}
