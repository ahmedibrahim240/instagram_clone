// ignore_for_file: constant_identifier_names

class Usermodels {
  static const ID = "id";
  static const NAME = "name";
  static const USERNAME = "username";
  static const EMAIL = "email";
  static const IMAGE = "image";
  static const BIO = "bio";
  static const FOLLOWERS = "followers";
  static const FOLLOWING = "following";

  String? id;
  String? name, userName;
  String? email, bio;
  String? image;
  List? followers;
  List? following;

  Usermodels({
    this.id,
    this.name,
    this.email,
    this.image,
    this.bio,
    this.userName,
    this.followers,
    this.following,
  });

  Usermodels.fromJson(snapshot) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    id = snapshot[ID];
    image = snapshot[IMAGE];
    bio = snapshot[BIO];
    userName = snapshot[USERNAME];
    followers = snapshot[FOLLOWERS] ?? [];
    following = snapshot[FOLLOWING] ?? [];
  }
  toJson() {
    return {
      ID: id,
      EMAIL: email,
      USERNAME: userName,
      NAME: name,
      IMAGE: image,
      BIO: bio,
      FOLLOWERS: followers,
      FOLLOWING: following,
    };
  }
}
