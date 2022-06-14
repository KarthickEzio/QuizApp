import 'package:flutter/material.dart';
import 'package:quizstar/quizpage.dart';
import 'package:quizstar/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class InfoScreen extends StatefulWidget {
  final List question;
  InfoScreen({@required this.question});
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  final asset = 'videos/info.mp4';
  VideoPlayerController controller;

  @override
  void initState(){
    super.initState();

    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {
        if (!controller.value.isPlaying && controller.value.isInitialized &&
            (controller.value.duration == controller.value.position)) { //checking the duration and position every time

          setState(() {});
        }
      }))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 200),
          VideoPlayerWidget(controller: controller,),
          SizedBox(height: 100),
          FloatingActionButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => getjson("Python"),
            ));
          },
          child: Icon(Icons.arrow_forward),),
        ],
      ),
    );
  }
}