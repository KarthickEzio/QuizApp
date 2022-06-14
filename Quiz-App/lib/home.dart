import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:quizstar/quizpage.dart';

import 'InfoScreen.dart';
import 'models/question.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> images = [
    "images/gk.jpg",
    "images/java.png",
    "images/js.png",
    "images/cpp.png",
    "images/linux.png",
  ];

  List<String> des = [
    "Test your General Knowledge.\nIf You think you have learnt it.. \nJust test yourself !!",
    "Java has always been one of the best choices for Enterprise World. If you think you have learn the Language...\nJust Test Yourself !!",
    "Javascript is one of the most Popular programming language supporting the Web.\nIt has a wide range of Libraries making it Very Powerful !",
    "C++, being a statically typed programming language is very powerful and Fast.\nit's DMA feature makes it more useful. !",
    "Linux is a OPEN SOURCE Operating System which powers many Servers and Workstation.\nIt is also a top Priority in Developement Work !",
  ];

  Widget customCard(String langname, String image, String des, bool status){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: (){
          if (status) {
            /*Navigator.of(context).pushReplacement(MaterialPageRoute(
              // in changelog 1 we will pass the langname name to ther other widget class
              // this name will be used to open a particular JSON file
              // for a particular language
              builder: (context) => getjson(langname),
            ));*/
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => InfoScreen(question: [Question()],),
            ));
          }
        },
        child: Stack(
          children: [
            Material(
              color: Colors.indigoAccent,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          // changing from 200 to 150 as to look better
                          height: 150.0,
                          width: 150.0,
                          child: ClipOval(
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                image,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        langname,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: "Quando",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        des,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: "Alike"
                        ),
                        maxLines: 5,
                        textAlign: TextAlign.justify,
                      ),

                    ),
                  ],
                ),
              ),
            ),
            status ? SizedBox() :Positioned(
              top: 0, left: 0, bottom: 0, right: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: Colors.black.withOpacity(0.6)),
                child: Icon(Icons.lock_outline_rounded,size: 100,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Quiz App",
                style: TextStyle(
                  fontFamily: "Quando",
                ),
              ),
            ),
            body: ListView(
              children: <Widget>[
                customCard("Python", images[0], des[0], true),
                customCard("Java", images[1], des[1], false),

              ],
            ),
          );
  }
}

Future<List<Question>> readJson() async {
  try {
    final jsonData = await rootBundle.rootBundle.loadString('jsonfile/question1.json');
    final list = json.decode(jsonData) as List<dynamic> ;
    return list.map((e) => Question.fromJson(e)).toList();
  } on Exception catch (e) {
    // TODO
    print("Error : "+e.toString());
  }
}