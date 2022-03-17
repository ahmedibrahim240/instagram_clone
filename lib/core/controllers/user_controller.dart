import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../models/user.dart';
import '../core_export.dart';

class Usercontroller extends GetxController {
  static Usercontroller instance = Get.find();
  RxBool showDiscoverPeople = false.obs;
  RxBool loadDiscoverPeople = false.obs;
  RxList secondUserFollowing = [].obs;
  Rx<List<Usermodels>> discoverPeopleList = Rx<List<Usermodels>>([]);
  List<Usermodels> get getDiscoverPeopleList => discoverPeopleList.value;
  RxString userProfileId = ''.obs;
  final CollectionReference _userCollection =
      firebaseFirestore.collection('users');
  @override
  void onReady() {
    super.onReady();
    showDiscoverPeople.value = false;
    loadDiscoverPeople.value = false;
  }

  Stream<Usermodels> getUserData(String uuid) {
    return _userCollection.doc(uuid).snapshots().map(
          (snapshot) => Usermodels.fromJson(
            snapshot.data(),
          ),
        );
  }

  setUserProfileInitData(String uuid) async {
    userProfileId.value = uuid;

    update();
  }

  updataloadDiscoverPeople(bool val) {
    if (!showDiscoverPeople.value) {
      loadDiscoverPeople.value = false;
    } else {
      loadDiscoverPeople.value = val;
    }
    update();
  }

  Stream<List<Usermodels>> discoverPeople(String id) {
    return _userCollection
        .where(
          Usermodels.ID,
          isNotEqualTo: authControllers.getcurrentUser.id,
        )
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Usermodels> retVal = [];
        for (var user in query.docs) {
          Usermodels newUser = Usermodels.fromJson(user);
          if (id != newUser.id) {
            retVal.add(
              newUser,
            );
          }
        }
        return retVal;
      },
    );
  }

  Future<void> folloUser({required String followId}) async {
    String curnetUserId = authControllers.currentUser.value.id!;
    List followingList = authControllers.currentUser.value.following!;
    try {
      if (followingList.contains(followId)) {
        await _userCollection.doc(followId).update(
          {
            Usermodels.FOLLOWERS: FieldValue.arrayRemove([curnetUserId]),
          },
        );
        await _userCollection.doc(curnetUserId).update(
          {
            Usermodels.FOLLOWING: FieldValue.arrayRemove([followId]),
          },
        );
      } else {
        await _userCollection.doc(followId).update(
          {
            Usermodels.FOLLOWERS: FieldValue.arrayUnion([curnetUserId]),
          },
        );
        await _userCollection.doc(curnetUserId).update(
          {
            Usermodels.FOLLOWING: FieldValue.arrayUnion([followId]),
          },
        );
      }
    } on FirebaseException catch (error) {
      customErrorSnakBar(
        error: error.message.toString(),
      );
    }
  }

  FollowState checkFollowUserState(String userID) {
    String curnetUserId = authControllers.currentUser.value.id!;
    List curnetUserFollowing = authControllers.currentUser.value.following!;

    if (userID == authControllers.currentUser.value.id) {
      return FollowState.IsMe;
    } else {
      if (curnetUserFollowing.contains(userID)) {
        return FollowState.UnFollow;
      } else {
        if (secondUserFollowing.contains(curnetUserId)) {
          return FollowState.FollowBack;
        } else {
          return FollowState.Follow;
        }
      }
    }
  }

  getSecndUserData(String id) async {
    // ignore: unnecessary_cast
    DocumentSnapshot snap = await _userCollection.doc(id).get();
    secondUserFollowing.value = (snap.data()! as dynamic)[Usermodels.FOLLOWING];
  }
}
