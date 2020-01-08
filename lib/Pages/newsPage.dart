import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/constants.dart';
import 'package:news/utils/news.dart';
import 'dart:convert';
import 'package:news/widgets/listTile.dart';
import 'package:url_launcher/url_launcher.dart';

List<Articles> newsarticles = [];

class newsPage extends StatefulWidget {
  @override
  _newsPageState createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  List<DropdownMenuItem> DropItems = [
    DropdownMenuItem(
      child: Text('عربي'),
      value: 'عربي',
    ),
    DropdownMenuItem(
      child: Text('En'),
      value: 'En',
    ),
  ];

  var SelectedITem='عربي';

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
                  _launchURL(newsarticles[index].url);
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

  DropdownButton buildDropdownButton() {
    return DropdownButton(
      value: 'عربى',
      items: DropItems,
      onChanged: (v) {
        SelectedITem = v;
        print(v);
        setState(() {});
      },
    );
  }

  getImage(String url) {
    Widget x;
    x = FadeInImage.assetNetwork(
      image: url,
      placeholder: 'assets/loading.gif',
      fit: BoxFit.cover,
      width: 100.0,
      height: 100.0,
    );
    return x;
  }
  _launchURL(ss) async {
    var url = ss;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
