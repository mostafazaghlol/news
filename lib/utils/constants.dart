import 'package:flutter/material.dart';

const apiToken = 'e8ec486d87a948bea30689ea024bc1eb';
const url = 'https://gnews.io/api/v3/top-news?token=$apiToken&lang=ar';
const urlNewsapi = 'https://newsapi.org/v2/top-headlines?country=eg&apiKey=e8ec486d87a948bea30689ea024bc1eb';
final topAppBar = AppBar(
  automaticallyImplyLeading: false,
  elevation: 0.1,
  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
  title: Text('news'),
);
final topAppBarSettings = AppBar(
  automaticallyImplyLeading: false,
  elevation: 0.1,
  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
  title: Text('news setttings'),
);

 
const splach = '/';
const newspage='/news';
const settings = '/settings';
const Ptextsize = 'textsize';
const Pcategoriy = 'textcat';
const Plange = 'textlanguage';