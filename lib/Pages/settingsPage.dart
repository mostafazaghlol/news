import 'package:flutter/material.dart';
import 'package:news/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingspage extends StatefulWidget {
  @override
  _settingspageState createState() => _settingspageState();
}

class _settingspageState extends State<settingspage> {
  SharedPreferences prefs;

  _setuppref() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(Pcategoriy)){
      currentSegment = prefs.getInt(Pcategoriy);
      setState(() {

      });
    }
    if(prefs.containsKey(Plange)){
      switchvalue = prefs.getBool(Plange);
      setState(() {

      });
    }
  }

  int textsize = 14;
  bool switchvalue = true;
  final Map<int, Widget> children = const <int, Widget>{
    0: Text(
      'General',
      style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0)),
    ),
    1: Text('Sports', style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
    2: Text('Health', style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
    3: Text('Science',
        style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
    4: Text('Tech', style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
  };
  int currentSegment = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setuppref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: topAppBarSettings,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: buildCupertinoSegmentedControl(),
            ),
            buildCardSize(),
            buildCardLanguage(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 55.0,
          child: BottomAppBar(
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CupertinoSegmentedControl<int> buildCupertinoSegmentedControl() {
    return CupertinoSegmentedControl<int>(
      borderColor: Colors.black,
      children: children,
      onValueChanged: onValueChanged,
      groupValue: currentSegment,
    );
  }

  Card buildCardLanguage() {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('English'),
          Switch(
            activeColor: Color.fromRGBO(58, 66, 86, 1.0),
            value: switchvalue,
            onChanged: (bool) async {
              setState(() {
                switchvalue = bool;
                print(bool);
              });
              await prefs.setBool(Plange, bool);
            },
          ),
          Text('عربي')
        ],
      ),
    );
  }

  Card buildCardSize() {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              setState(() {
                textsize++;
              });
              await prefs.setDouble(Ptextsize, textsize.toDouble());
            },
          ),
          Text(textsize.toString()),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () async{
              setState(() {
                textsize--;
              });
              await prefs.setDouble(Ptextsize, textsize.toDouble());
            },
          ),
          Text('Title Size', style: TextStyle(fontSize: textsize.toDouble())),
        ],
      ),
    );
  }

  void onValueChanged(int newValue) {
    setState(()  {
      currentSegment = newValue;
    });
    prefs.setInt(Pcategoriy, newValue);

  }
}
