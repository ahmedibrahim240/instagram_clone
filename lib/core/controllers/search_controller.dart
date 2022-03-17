import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class SearchController extends GetxController {
  static SearchController instance = Get.find();
  Rx<String> searshText = Rx<String>('');
  RxBool isNotData = false.obs;
  @override
  void onReady() {
    super.onReady();
    searshText.value = '';
    isNotData.value = false;
  }

  Stream<List<Usermodels>> searchByUserName() {
    List<Usermodels> retVal = [];
    return firebaseFirestore.collection('users').snapshots().map(
      (QuerySnapshot query) {
        for (var doc in query.docs) {
          Usermodels user = Usermodels.fromJson(doc);

          if (searshText.value.isEmpty) {
            retVal.clear();
            isNotData.value = true;
          } else {
            if (user.userName.toString().toLowerCase().contains(
                  searshText.value.toLowerCase(),
                )) {
              isNotData.value = false;
              retVal.add(user);
            } else {
              isNotData.value = true;
            }
          }
        }
        return retVal;
      },
    );
  }
}
