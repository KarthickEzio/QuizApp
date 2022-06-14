import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:quizstar/models/question.dart';
import 'package:quizstar/resultpage.dart';
import 'package:flutter/services.dart' as rootBundle;

class getjson extends StatelessWidget {
  // accept the langname as a parameter

  String langname;
  getjson(this.langname);
  String assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setAsset() {
    if (langname == "Python") {
      assettoload = "jsonfile/question1.json";
    } else {
      assettoload = "jsonfile/question1.json";
    }
  }

  Future<List<Question>> readJson() async {
    final jsonData = await rootBundle.rootBundle.loadString('jsonfile/question1.json');
    final list = json.decode(jsonData) as List<dynamic> ;
    return list.map((e) => Question.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    return FutureBuilder(
      future:
      DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return QuizPage(mydata: myData);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final List mydata;

  QuizPage({Key key, @required this.mydata}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(mydata);
}

class _QuizPageState extends State<QuizPage> {
  final List myData;
  _QuizPageState(this.myData);

  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  // extra varibale to iterate
  int j = 1;
  int timer = 5;
  String showTimer = "5";
  var randomArray;

  Map<String, Color> btnColor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool cancelTimer = false;

  // code inserted for choosing questions randomly
  // to create the array elements randomly use the dart:math module
  // -----     CODE TO GENERATE ARRAY RANDOMLY

  genRandomArray(){
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0; ;) {
      distinctIds.add(rand.nextInt(2));
      randomArray = distinctIds.toSet().toList();
      if(randomArray.length < 2){
        continue;
      }else{
        break;
      }
    }
    print(randomArray);
  }

  //   var random_array;
  //   var distinctIds = [];
  //   var rand = new Random();
  //     for (int i = 0; ;) {
  //     distinctIds.add(rand.nextInt(10));
  //       random_array = distinctIds.toSet().toList();
  //       if(random_array.length < 10){
  //         continue;
  //       }else{
  //         break;
  //       }
  //     }
  //   print(random_array);

  // ----- END OF CODE
  // var random_array = [1, 6, 7, 2, 4, 10, 8, 3, 9, 5];

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    startTimer();
    genRandomArray();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 5;
    setState(() {
      if (j < 10) {
        i = randomArray[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btnColor["a"] = Colors.indigoAccent;
      btnColor["b"] = Colors.indigoAccent;
      btnColor["c"] = Colors.indigoAccent;
      btnColor["d"] = Colors.indigoAccent;
      disableAnswer = false;
    });
    startTimer();
  }

  void checkAnswer(String k) {

    // in the previous version this was
    // mydata[2]["1"] == mydata[1]["1"][k]
    // which i forgot to change
    // so nake sure that this is now corrected
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
      marks = marks + 5;
      // changing the color variable to be green
      colorToShow = right;
    } else {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
      colorToShow = wrong;
    }
    setState(() {
      // applying the changed color to the particular button that was selected
      btnColor[k] = colorToShow;
      cancelTimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(Duration(seconds: 2), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Text(
          myData[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Class Edge",
              ),
              content: Text("You Can't Go Back At This Stage."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                  ),
                )
              ],
            ));
      },
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Lottie.network('https://assets7.lottiefiles.com/packages/lf20_ym8w5cx4.json'),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        myData[0][i.toString()],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Quando",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    width: 170,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 10,
                          value: timer / 5,
                        ),
                        Center(
                          child: Text(
                            "0 : 0"+showTimer,
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: AbsorbPointer(
                      absorbing: disableAnswer,
                      child: Container(
                        child: GridView.count(
                          crossAxisSpacing: 20.0,
                          crossAxisCount: 2,
                          children: [
                            choiceButton('a'),
                            choiceButton('b'),
                            choiceButton('c'),
                            choiceButton('d'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
