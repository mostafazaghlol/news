import 'package:flutter/material.dart';

const apiToken = 'e0844a946c66381cbede866f06395e69';
const url = 'https://gnews.io/api/v3/top-news?token=$apiToken&lang=ar';
final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
  title: Text('news'),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.list),
      onPressed: () {},
    )
  ],
);

final makeBottom = Container(
  height: 55.0,
  child: BottomAppBar(
    color: Color.fromRGBO(58, 66, 86, 1.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {},
        ),
      ],
    ),
  ),
);
 
const splach = '/';
const newspage='/news';
const settings = '/settings';
