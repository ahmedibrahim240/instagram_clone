import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/models_export.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class FollowerController extends GetxController {
  static FollowerController instance = Get.find();
  Rx<List<FollowModels>> followersList = Rx<List<FollowModels>>([]);
  Rx<List<FollowModels>> followingList = Rx<List<FollowModels>>([]);
  List<FollowModels> get getFollowersList => followersList.value;
  List<FollowModels> get getFollowingList => followingList.value;
  String followersCollection = "followers";
  String followingCollection = "following";
  String userCollection = "users";
  RxBool isFollow = false.obs;
  @override
  void onInit() {
    super.onInit();
    followersList
        .bindStream(followersStream(authControllers.currentUser.value.id!));
    followingList
        .bindStream(followingStream(authControllers.currentUser.value.id!));
    debugPrint("________________________");
    for (var follower in getFollowingList) {
      debugPrint("follower:${follower.toJson()}");
    }
    debugPrint("________________________");
  }

  followUser(
      {required FollowModels followModels,
      required String currentUserId,
      required String secondUserId}) async {
    try {
      await firebaseFirestore
          .collection(userCollection)
          .doc(currentUserId)
          .collection(followingCollection)
          .add(
            followModels.toJson(),
          );
    } on FirebaseException catch (error) {
      customErrorSnakBar(
        error: error.message.toString(),
      );
    }
  }

  Stream<List<FollowModels>> followersStream(String uid) {
    return firebaseFirestore
        .collection(userCollection)
        .doc(uid)
        .collection(followersCollection)
        .orderBy(FollowModels.DATECREATED, descending: true)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<FollowModels> retVal = [];
        for (var follower in query.docs) {
          retVal.add(FollowModels.fromJson(follower));
        }

        return retVal;
      },
    );
  }

  Stream<List<FollowModels>> followingStream(String uid) {
    return firebaseFirestore
        .collection(userCollection)
        .doc(uid)
        .collection(followingCollection)
        .orderBy(FollowModels.DATECREATED, descending: true)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<FollowModels> retVal = [];
        for (var follower in query.docs) {
          retVal.add(FollowModels.fromJson(follower));
        }

        return retVal;
      },
    );
  }

  unFollowUser({
    required String followId,
    required String currentUserId,
    required String secondUserId,
  }) async {
    await firebaseFirestore
        .collection(userCollection)
        .doc(currentUserId)
        .collection(followingCollection)
        .doc(followId)
        .delete();
  }

  bool checkIsFollowUser(String userId) {
    return getFollowingList
        .where((follower) => follower.userID == userId)
        .isNotEmpty;
  }
}
