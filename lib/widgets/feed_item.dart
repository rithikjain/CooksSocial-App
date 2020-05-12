import 'package:cooks_social/data/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FeedItem extends StatefulWidget {
  final Recipe recipe;

  FeedItem({@required this.recipe});

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/avatar.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Rithik Jain",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF030301),
                      ),
                    ),
                    Text(
                      "rithikthechef",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(3, 3, 1, 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "9:42 pm",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(3, 3, 1, 0.5),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Butter paneer with garlic naan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/foodtemp.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 45,
                      child: Text(
                        "Like (63)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 1.1,
                        ),
                      ),
                      color: Color(0xFF1789FC),
                      disabledColor: Color.fromRGBO(23, 137, 252, 0.2),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 45,
                      child: Text(
                        "Favourite",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 1.1,
                        ),
                      ),
                      color: Color(0xFFFAC05E),
                      disabledColor: Color.fromRGBO(250, 192, 94, 0.2),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
