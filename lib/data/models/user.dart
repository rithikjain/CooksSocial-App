class User {
  int id;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String name;
  String username;
  String phoneNumber;
  String email;
  String password;
  String profileImgUrl;
  int following;
  int followers;
  String bio;
  bool verified;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.name,
      this.username,
      this.phoneNumber,
      this.email,
      this.password,
      this.profileImgUrl,
      this.following,
      this.followers,
      this.bio,
      this.verified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    name = json['name'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    profileImgUrl = json['profile_img_url'];
    following = json['following'];
    followers = json['followers'];
    bio = json['bio'];
    verified = json['verified'];
  }
}
