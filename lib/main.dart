import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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

  List<Icon> userResults = [];
  int score = 0;

  List<Question> questions = [
    Question(q: 'The African elephant is the largest carnivore on land.', a: false),
    Question(q: '\'A\' is the most common letter used in the English language.', a: false),
    Question(q: 'Australia is wider than the moon.', a: true),
    Question(q: 'Alaska is the biggest American state in square miles.', a: true),
    Question(q: 'There are five different blood groups.', a: false),
    Question(q: 'The river Seine in Paris is longer than the river Thames in London.', a: true),
    Question(q: 'Monaco is the smallest country in the world.', a: false),
  ];

  Question a1;

  void handleAnswer(bool answer){
      setState(() {
        userResults.add(
          Icon(
            Icons.check,
            color: (answer == questions[userResults.length].answer ? Colors.green : Colors.red),
          ),
        );
        if(answer == questions[userResults.length - 1].answer)
          score++;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
            height: MediaQuery.of(context).size.height * 0.14,
            //color: Colors.blue,
            child: Text(
            (userResults.length<7) ? questions[userResults.length].question : 'Your Score is: $score/7',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
          if(userResults.length<7)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  color: Colors.green,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    if(userResults.length<7)
                      handleAnswer(true);
                  },
                ),
                FlatButton(
                  color: Colors.red,
                  child: Text(
                    'False',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    if(userResults.length<7)
                      handleAnswer(false);
                  },
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            //color: Colors.blue,
            child: Row(
              children: userResults,
            ),
          ),
        ],
      ),
    );
  }
}
