import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
// import '';
import 'package:fluttertoast/fluttertoast.dart';
class MyQuize extends StatefulWidget {
  const MyQuize({super.key});

  @override
  State<MyQuize> createState() => _MyQuizeState();
}

class _MyQuizeState extends State<MyQuize> {
  var currentindex = 0;
  var auth = AuthServices();
  List<dynamic> quizedata = [];
  String? accessToken;
  String selectedOption = '';
  bool answerSubmitted = false;
  int correctAnswers = 0; // Track the number of correct answers

  @override
  void initState() {
    super.initState();
    getTemplates();
  }

  getTemplates() async {
    SharedPreferences setToken = await SharedPreferences.getInstance();
    accessToken = setToken.getString('entrytoken');
    debugPrint('fcm get share $accessToken');

    Map<String, dynamic> map = await auth.GetRequest(
        'getQuiz?quizId=66a9c58c1a60f095cb37d128',
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOnsiX2lkIjoiNjZhMGE3YzQ2ODBlNDFiZjRkMTJhZmVlIiwiZW1haWwiOiJzYWhpbEBnbWFpbC5jb20iLCJfX3YiOjAsImNyZWF0ZWRfYXQiOiIyMDI0LTA3LTI0VDA2OjU4OjQxLjUxMVoiLCJuYW1lIjoiU2FoaWwiLCJvcmdhbml6YXRpb25JZCI6IjY2ODNiNGE0OTliMTM0YmIyYmU2MjI5NCIsIm90cCI6IjE2MzUiLCJvdHBHZW5lcmF0ZWRBdCI6IjIwMjQtMDctMjlUMDc6NDE6NDguNTYxWiIsInBob25lTnVtYmVyIjoiNzg5MDkwOTA5MDkwIiwicm9sZUlkIjoiNjY4M2E1ZjExZDdmNmQxOTE5YzQ3MWQ2In0sImlhdCI6MTcyMjIzODkxNCwiZXhwIjoxNzUzNzk2NTE0fQ.DZy_JLnfK9rebZDdJqvT-ssPRQOapExG_SO8ZGQDZ6w");
    print('templates Data mapppp$map');

    if (map['status'] == true) {
      setState(() {
        quizedata = map['data'][0]['questions']; // Get the questions list
        print('templates Data=========$quizedata');
      });
    } else if (map['status'] == false) {
      print('Update User Profile API Failed');
    } else {
      print('Failed');
    }
  }

  void nextQuestion() {
    if (currentindex < quizedata.length - 1) {
      setState(() {
        currentindex++;
        selectedOption = ''; // Reset the selected option
        answerSubmitted = false; // Reset the answer submission state
      });
    } else {
      // Show quiz result when quiz is completed
      showResultDialog();
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text(
              'You got $correctAnswers out of ${quizedata.length} correct!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  // Reset the quiz
                  currentindex = 0;
                  correctAnswers = 0;
                  selectedOption = '';
                  answerSubmitted = false;
                });
              },
              child: Text('Restart Quiz'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Exit the quiz screen
              },
              child: Text('Exit Quiz'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Quiz App")),
      ),
      body: quizedata.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Question ${quizedata[currentindex]['questionNo']} of ${quizedata.length}'),
                  const SizedBox(height: 20),
                  Text(quizedata[currentindex]['question']),
                  const SizedBox(height: 20),
                 Expanded(
                    child: ListView.builder(
                      itemCount: quizedata[currentindex]['options'].length,
                      itemBuilder: (context, index) {
                        String option = quizedata[currentindex]['options'][index];
                        bool isSelected = option == selectedOption;
                        return GestureDetector(
                          onTap: () {
                            if (!answerSubmitted) {
                              setState(() {
                                selectedOption = option;
                              });
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(option,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedOption.isNotEmpty && !answerSubmitted
                       ? () {
                            setState(() {
                              answerSubmitted = true;
                            });
                            if (selectedOption ==
                                quizedata[currentindex]['correctOption']) {
                              correctAnswers++;
                              print('ifff');
                              Fluttertoast.showToast(
                                  msg: 'correct',
                                  timeInSecForIosWeb: 5,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              print('elseeee');
                              Fluttertoast.showToast(
                                  msg: 'Incorrect',
                                  timeInSecForIosWeb: 5,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        : null,
                    child: const Text('Submit Answer'),
                  ),
                  const SizedBox(height: 10),
                  if (answerSubmitted)
                    ElevatedButton(
                      onPressed: nextQuestion,
                      child: Text(currentindex < quizedata.length - 1
                          ? 'Next Question'
                          : 'Finish Quiz'),
                    ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
