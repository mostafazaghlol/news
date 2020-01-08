import 'package:flutter/material.dart';
import 'Pages/newsPage.dart';
import 'Pages/settingsPage.dart';
import 'package:news/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/constants.dart';
import 'package:news/utils/news.dart';
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      initialRoute: splach,
      routes: {
        splach:(context)=>MyHomePage(),
        newspage:(context)=>newsPage(),
        settings:(context)=>settingspage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static news N;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
  }
  _getnews() async {
    http.Response response = await http.get(url).then((onValue) {
      MyHomePage.N = news.fromJson(json.decode(onValue.body));
      newsarticles = MyHomePage.N.articles;
      setState(() async{
        Duration d = Duration(seconds: 2);
        Future dx = await Future.delayed(d);
        Navigator.pushNamed(context, newspage);
      });
      return null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getnews();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // This trailing comma makes auto-formatting nicer for build methods.

      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 20.0, height: 100.0),
            Text(
              "News",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(width: 20.0, height: 10.0),
            RotateAnimatedTextKit(
                duration: Duration(seconds: 2),
                totalRepeatCount: 1,
                onFinished: (){
                  Navigator.pushNamed(context, newspage);
                },
                text: ["Entertainment","Sports","Business"],
                textStyle: TextStyle(fontSize: 20.0, fontFamily: "Horizon"),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
          ],
        ),
      ),
    );
  }
}
