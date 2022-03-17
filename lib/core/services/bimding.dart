import 'package:get/get.dart';
import 'package:instagram_clone/core/controllers/verify_email_conttroller.dart';
import 'package:instagram_clone/core/core_export.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthControllers>(AuthControllers());
    Get.put<RouteController>(RouteController());
    Get.put<NavBarController>(NavBarController());
    Get.put<RefreshContrllors>(RefreshContrllors());
    Get.put<SplachController>(SplachController());
    Get.put<ImagePickerConttroller>(ImagePickerConttroller());
    Get.put<SearchController>(SearchController());
    Get.put<Usercontroller>(Usercontroller());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<FollowerController>(() => FollowerController());
    Get.lazyPut<VerifyEmailController>(() => VerifyEmailController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<PostController>(() => PostController());
  }
}
