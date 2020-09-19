import 'question.dart';

class QuizBrain {
  List<Question> _questions = [
    Question('The African elephant is the largest carnivore on land.', false),
    Question('\'A\' is the most common letter used in English.', false),
    Question('Australia is wider than the moon.', true),
    Question('Alaska is the biggest American state in square miles.', true),
    Question('There are five different blood groups.', false),
    Question('The river Seine in Paris is longer than Thames in London.', true),
    Question('Monaco is the smallest country in the world.', false),
  ];

  String getQuestionText(questionNumber) {
    return _questions[questionNumber].question;
  }

  bool getAnswer(questionNumber) {
    return _questions[questionNumber].answer;
  }
}
