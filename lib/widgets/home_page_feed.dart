import 'package:cooks_social/data/models/recipe.dart';
import 'package:cooks_social/widgets/feed_item.dart';
import 'package:flutter/material.dart';

class HomePageFeed extends StatelessWidget {
  final Recipe recipe1 = Recipe(
    userImg: "",
    username: "",
    imgUrl: "",
    updatedAt: "",
    recipeName: "",
    likes: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FeedItem(recipe: recipe1),
            FeedItem(recipe: recipe1),
            FeedItem(recipe: recipe1),
            FeedItem(recipe: recipe1),
          ],
        ),
      ),
    );
  }
}
