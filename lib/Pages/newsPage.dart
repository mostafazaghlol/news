import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/constants.dart';
import 'package:news/utils/news.dart';
import 'dart:convert';
import 'package:news/widgets/listTile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Articles> newsarticles = [];
class newsPage extends StatefulWidget {
  @override
  _newsPageState createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  SharedPreferences prefs;
  _setuppref() async {
    prefs = await SharedPreferences.getInstance();
  }


  var SelectedITem='عربي';
  var titlesize = 14.0;

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
              titleSize:titlesize,
              image: getImage(newsarticles[index].urlToImage),
              title: newsarticles[index].title,
              subtitl: newsarticles[index].source.name,
              func: () {
                  _launchURL(newsarticles[index].url);
              }).buildlistcard();
        },
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  var result = Navigator.pushNamed(context, settings);
                  result.then((c){
                    print('hi');
                    _getpass();
                  });
                },
              ),
            ],
          ),
        ),
      ),
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
    await _setuppref();
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = getUrl();
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    news N = news.fromJson(json.decode(reply));
    newsarticles = N.articles;
    setState(() {});
    print(reply);
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

  String getUrl() {
    String country = 'eg';
    if(prefs.containsKey(Plange)){
      if(prefs.getBool(Plange)){
        country = 'eg';
      }else{
        country = 'gb';
      }
    }
    String cat='&category=';
    if(prefs.containsKey(Pcategoriy)){
      int catno = prefs.getInt(Pcategoriy);
      if(catno== 0){
        cat = '';
      }else if(catno == 1){
        cat = cat +'sports';
      }else if(catno == 2){
        cat = cat +'health';
      }else if(catno == 3){
        cat = cat +'science';
      }else{
        cat = cat +'technology';
      }
    }else{
      cat = '';
    }
    if(prefs.containsKey(Ptextsize)){
      titlesize = prefs.getDouble(Ptextsize);
    }
    return 'https://newsapi.org/v2/top-headlines?country=$country'+cat+'&apiKey=e8ec486d87a948bea30689ea024bc1eb';
  }
}
