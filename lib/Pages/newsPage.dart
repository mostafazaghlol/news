import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/constants.dart';
import 'package:news/utils/news.dart';
import 'dart:convert';
import 'package:news/widgets/listTile.dart';
 
List<Articles> newsarticles = List();
class newsPage extends StatefulWidget {
  @override
  _newsPageState createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getnews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:topAppBar,
      body: ListView.builder(
        itemCount: newsarticles.length,
        
        itemBuilder: (context, index) {
          return ListTileWithCard(
            title: newsarticles[index].title,
            subtitl:  newsarticles[index].source.name,
            func: (){
              print(index);
            }
          ).buildlistcard();
        },
      ),
      bottomNavigationBar: makeBottom,
    );
  }

  _getnews() async{
      http.Response response = await http.get(url).then((onValue){
        news N = news.fromJson(json.decode(onValue.body));
        newsarticles = N.articles;
        setState(() {
          
        });
        return null;
      });

  }
}
