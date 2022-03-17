// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FollowModels {
  static const USERID = "userId";
  static const ID = "Id";
  static const DATECREATED = "dateCreated";
  String? userID, id;
  Timestamp? dateCreated;
  FollowModels({
    this.id,
    this.dateCreated,
    this.userID,
  });
  FollowModels.fromJson(DocumentSnapshot snapshot) {
    userID = snapshot[USERID];
    id = snapshot.id;
    dateCreated = snapshot[DATECREATED];
  }
  Map<String, dynamic> toJson() {
    return {
      USERID: userID,
      DATECREATED: dateCreated,
    };
  }
}
