// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(GeoQuizApp());
}

class GeoQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoQuiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [
    {"question": "Canberra is the capital of Australia.", "answer": true},
    {
      "question": "The Pacific Ocean is larger than the Atlantic Ocean.",
      "answer": true
    },
    {
      "question": "The Suez Canal connects the Red Sea and the Indian Ocean.",
      "answer": true
    },
    {"question": "The source of the Nile River is in Egypt.", "answer": true},
    {
      "question": "The Amazon River is the longest river in the Americas.",
      "answer": true
    },
    {
      "question":
          "Lake Baikal is the world's oldest and deepest freshwater lake.",
      "answer": true
    },
  ];

  int currentQuestionIndex = 0;
  bool isCheatScreenVisible = false;
  bool isAnswerShown = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          isAnswerShown = false;
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('GeoQuiz'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                questions[currentQuestionIndex]["question"],
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: Text('True'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: Text('False'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCheatScreenVisible = !isCheatScreenVisible;
                    isAnswerShown = true;
                  });
                },
                child: Text('Show Answers'),
              ),
              SizedBox(height: 20),
              if (isCheatScreenVisible && isAnswerShown) ...[
                Text(
                  'Cheat Screen',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(
                  children: List.generate(
                    questions.length,
                    (index) {
                      return Text(
                        '${questions[index]["question"]}: ${questions[index]["answer"]}',
                        style: TextStyle(fontSize: 16),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                if (isCheatScreenVisible)
                  Text(
                    'You have cheated!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questions[currentQuestionIndex]["answer"];
    if (userAnswer == correctAnswer) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text('You answered correctly.'),
            actions: [
              TextButton(
                child: Text('Next Question'),
                onPressed: () {
                  setState(() {
                    currentQuestionIndex =
                        (currentQuestionIndex + 1) % questions.length;
                    isAnswerShown = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Wrong!'),
            content: Text('You answered incorrectly.'),
            actions: [
              TextButton(
                child: Text('Next Question'),
                onPressed: () {
                  setState(() {
                    currentQuestionIndex =
                        (currentQuestionIndex + 1) % questions.length;
                    isAnswerShown = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
