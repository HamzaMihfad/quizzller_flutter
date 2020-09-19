import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3F51B5),
          title: Text('Quizzler App'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  play(audioPlayer, audioCache, audioFile) async {
    if (audioPlayer == null)
      audioPlayer = await audioCache.play('audios/$audioFile');
    else
      await audioPlayer.resume();
  }

  List<Icon> userResults = [];
  int score = 0;
  int index = 0;

  void handleAnswer(bool answer) {
    if (index < 6) {
      AudioPlayer audioPlayer;
      final audioCache = AudioCache();

      setState(() {
        userResults.add(
          Icon(
            (answer == quizBrain.getAnswer(index) ? Icons.check : Icons.close),
            color: (answer == quizBrain.getAnswer(index)
                ? Color(0xff00e676)
                : Colors.red),
            size: 40,
          ),
        );
        if (answer == quizBrain.getAnswer(index)) {
          this.play(audioPlayer, audioCache, 'correct.wav');
          score++;
        } else
          this.play(audioPlayer, audioCache, 'wrong.mp3');
        index++;
      });
    } else {
      Alert(
        context: context,
        title: "Your score is $score/7",
        desc: "Good Job !",
        buttons: [
          DialogButton(
            child: Text(
              "Play Again!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                userResults = [];
                score = 0;
                index = 0;
              });
              Navigator.pop(context);
            },
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20,
                right: 12,
                left: 12),
            height: MediaQuery.of(context).size.height * 0.14,
            //color: Colors.blue,
            child: Center(
              child: Text(
                (index < 7) ? quizBrain.getQuestionText(index) : 'Replay',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ),
          if (index < 7)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.only(bottom: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: Color(0xff00e676),
                      child: SizedBox(
                        width: 80,
                        height: 45,
                        child: Center(
                          child: Text(
                            'true',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (index < 7) handleAnswer(true);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    RaisedButton(
                      color: Color(0xfff50057),
                      child: SizedBox(
                        width: 80,
                        height: 45,
                        child: Center(
                          child: Text(
                            'false',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (index < 7) handleAnswer(false);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Container(
            height: 42,
            color: Colors.blue.shade800,
            width: MediaQuery.of(context).size.width * 2,
            child: Row(
              children: userResults,
            ),
          ),
        ],
      ),
    );
  }
}
