import 'dart:io';
import 'package:flag/flag.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/constants.dart';
import 'package:news/utils/news.dart';
import 'dart:convert';
import 'package:news/widgets/listTile.dart';

List<Articles> newsarticles = [];

class newsPage extends StatefulWidget {
  @override
  _newsPageState createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getpass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: ListView.builder(
        itemCount: newsarticles.length,
        itemBuilder: (context, index) {
          return ListTileWithCard(
              image: getImage(newsarticles[index].urlToImage),
              title: newsarticles[index].title,
              subtitl: newsarticles[index].source.name,
              func: () {
                print(index);
              }).buildlistcard();
        },
      ),
      bottomNavigationBar: makeBottom,
    );
  }

  _getnews() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == "https://newsapi.org/";
      return isValidHost;
    });
    http.Response response = await http.get(urlNewsapi).then((onValue) {
      print(onValue.body);
      news N = news.fromJson(json.decode(onValue.body));
      newsarticles = N.articles;
      setState(() {});
      return null;
    });
  }

  _getpass() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String url = urlNewsapi;

//   Map map = {
//     "email" : "email" ,
//     "password" : "password"
//   };

    HttpClientRequest request = await client.getUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');

//   request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();
    news N = news.fromJson(json.decode(reply));
    newsarticles = N.articles;
    setState(() {});
    print(reply);
  }

  getImage(String url) {
    if(url == null){
      return Flags.getFullFlag('EG', 30, null);
    }else{
      Widget x;
      try{
        x = Image(image: NetworkImage(url),fit:BoxFit.cover,width: 100.0,);
      }catch (e){
        x = Flags.getFullFlag('EG', 30, null);
      }
      return  x;
    }
  }
}
