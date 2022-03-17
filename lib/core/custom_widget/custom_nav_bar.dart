import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/models_export.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class CustonNavBar extends StatelessWidget {
  const CustonNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _body = const [
      NetworkSensitive(
        child: CustomRefreshWidget(child: HomeScrean()),
      ),
      NetworkSensitive(
        child: SearchScrean(),
      ),
      NetworkSensitive(
        child: SizedBox(),
      ),
      NetworkSensitive(
        child: CustomRefreshWidget(
          child: UserProfileScrean(),
        ),
      ),
    ];
    if (Get.arguments != null) {
      navBarController.setCurretIndex(Get.arguments);
    }
    return Obx(
      () => Scaffold(
        body: _body[navBarController.currentIndex.value],
        bottomNavigationBar: NetworkSensitive(
          isNavBar: true,
          child: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: kMobileSearchColor, width: .5),
                ),
              ),
              child: BottomNavigationBar(
                elevation: 0.0,
                currentIndex: navBarController.currentIndex.value,
                backgroundColor: themeController.darkMode.value
                    ? kMobileBackgroundColor
                    : kPrimaryColor,
                selectedItemColor: themeController.getPrimaryColor,
                unselectedItemColor: themeController.getPrimaryColor,
                iconSize: 30,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  if (index == 2) {
                    routeController.routePage(
                      type: RouteType.To,
                      page: () => const UploadPostScrean(),
                      transition: Transition.leftToRight,
                    );
                  } else {
                    if (index == 1) {
                      searchController.searshText.value = '';
                    }
                    if (index == 3) {
                      usercontroller.setUserProfileInitData(
                        authControllers.getcurrentUser.id!,
                      );
                    }

                    navBarController.currentIndex.value = index;
                  }
                },
                items: navBarItemList
                    .map(
                      (item) => BottomNavigationBarItem(
                        activeIcon: _setIcons(item.icon, context),
                        icon: _setIcons(
                          item.unselectedIcons,
                          context,
                        ),
                        label: '',
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _setIcons(icon, BuildContext context) {
    if (icon == null) {
      return GetX(
        init: Get.put<AuthControllers>(AuthControllers()),
        builder: (AuthControllers controller) {
          if (controller.getcurrentUser.image == null) {
            return const Icon(Icons.person);
          } else {
            return Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: navBarController.currentIndex.value != 3
                    ? Colors.transparent
                    : themeController.getPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: CircleImge(
                radius: 35,
                width: 35,
                height: 35,
                url: controller.getcurrentUser.image!,
                boxFit: BoxFit.cover,
              ),
            );
          }
        },
      );
    } else {
      return Icon(
        icon,
      );
    }
  }
}
