class Recipe {
  int id;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  int userId;
  String recipeName;
  String description;
  String ingredients;
  int difficulty;
  String procedure;
  String imgUrl;
  String username;
  String userImg;
  int likes;

  Recipe(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.recipeName,
      this.description,
      this.ingredients,
      this.difficulty,
      this.procedure,
      this.imgUrl,
      this.username,
      this.userImg,
      this.likes});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    userId = json['user_id'];
    recipeName = json['recipe_name'];
    description = json['description'];
    ingredients = json['ingredients'];
    difficulty = json['difficulty'];
    procedure = json['procedure'];
    imgUrl = json['img_url'];
    username = json['username'];
    userImg = json['user_img'];
    likes = json['likes'];
  }
}
