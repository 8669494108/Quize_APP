// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
    bool status;
    String message;
    List<Datum> data;

    ModelUser({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String quizTopic;
    String quizId;
    List<Question> questions;

    Datum({
        required this.quizTopic,
        required this.quizId,
        required this.questions,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        quizTopic: json["quizTopic"],
        quizId: json["quizId"],
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "quizTopic": quizTopic,
        "quizId": quizId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Question {
    String id;
    QuestionType questionType;
    int questionNo;
    String question;
    List<String> options;
    String correctOption;
    String explanation;

    Question({
        required this.id,
        required this.questionType,
        required this.questionNo,
        required this.question,
        required this.options,
        required this.correctOption,
        required this.explanation,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        questionType: questionTypeValues.map[json["questionType"]]!,
        questionNo: json["questionNo"],
        question: json["question"],
        options: List<String>.from(json["options"].map((x) => x)),
        correctOption: json["correctOption"],
        explanation: json["explanation"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "questionType": questionTypeValues.reverse[questionType],
        "questionNo": questionNo,
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x)),
        "correctOption": correctOption,
        "explanation": explanation,
    };
}

enum QuestionType {
    TEXT
}

final questionTypeValues = EnumValues({
    "text": QuestionType.TEXT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
