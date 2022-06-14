// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    this.instructions,
    this.metadata,
    this.questionId,
    this.data,
    this.solution,
    this.attachment,
    this.solutionStrategies,
    this.style,
    this.type,
    this.widgetType,
  });

  String instructions;
  QuestionMetadata metadata;
  String questionId;
  Data data;
  QuestionSolution solution;
  String attachment;
  String solutionStrategies;
  Style style;
  String type;
  String widgetType;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    instructions: json["instructions"],
    metadata: QuestionMetadata.fromJson(json["metadata"]),
    questionId: json["questionID"],
    data: Data.fromJson(json["data"]),
    solution: QuestionSolution.fromJson(json["solution"]),
    attachment: json["attachment"],
    solutionStrategies: json["solutionStrategies"],
    style: Style.fromJson(json["style"]),
    type: json["type"],
    widgetType: json["widget_type"],
  );

  Map<String, dynamic> toJson() => {
    "instructions": instructions,
    "metadata": metadata.toJson(),
    "questionID": questionId,
    "data": data.toJson(),
    "solution": solution.toJson(),
    "attachment": attachment,
    "solutionStrategies": solutionStrategies,
    "style": style.toJson(),
    "type": type,
    "widget_type": widgetType,
  };
}

class Data {
  Data({
    this.stimulusMedia,
    this.metadata,
    this.solution,
    this.stimulus,
    this.options,
    this.style,
    this.marks,
    this.type,
  });

  String stimulusMedia;
  DataMetadata metadata;
  StyleClass solution;
  String stimulus;
  List<Option> options;
  StyleClass style;
  int marks;
  String type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    stimulusMedia: json["stimulus_media"],
    metadata: DataMetadata.fromJson(json["metadata"]),
    solution: StyleClass.fromJson(json["solution"]),
    stimulus: json["stimulus"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    style: StyleClass.fromJson(json["style"]),
    marks: json["marks"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "stimulus_media": stimulusMedia,
    "metadata": metadata.toJson(),
    "solution": solution.toJson(),
    "stimulus": stimulus,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "style": style.toJson(),
    "marks": marks,
    "type": type,
  };
}

class DataMetadata {
  DataMetadata({
    this.duration,
    this.difficulty,
    this.distractorRationale,
    this.bloom,
    this.acknowledgements,
    this.construct,
    this.shuffle,
    this.version,
    this.microConcept,
  });

  int duration;
  String difficulty;
  Acknowledgements distractorRationale;
  String bloom;
  Acknowledgements acknowledgements;
  String construct;
  bool shuffle;
  int version;
  List<MicroConcept> microConcept;

  factory DataMetadata.fromJson(Map<String, dynamic> json) => DataMetadata(
    duration: json["duration"],
    difficulty: json["difficulty"],
    distractorRationale: Acknowledgements.fromJson(json["distractor_rationale"]),
    bloom: json["bloom"],
    acknowledgements: Acknowledgements.fromJson(json["acknowledgements"]),
    construct: json["construct"],
    shuffle: json["shuffle"],
    version: json["version"],
    microConcept: List<MicroConcept>.from(json["microConcept"].map((x) => MicroConcept.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "difficulty": difficulty,
    "distractor_rationale": distractorRationale.toJson(),
    "bloom": bloom,
    "acknowledgements": acknowledgements.toJson(),
    "construct": construct,
    "shuffle": shuffle,
    "version": version,
    "microConcept": List<dynamic>.from(microConcept.map((x) => x.toJson())),
  };
}

class Acknowledgements {
  Acknowledgements({
    this.label,
    this.audio,
  });

  String label;
  String audio;

  factory Acknowledgements.fromJson(Map<String, dynamic> json) => Acknowledgements(
    label: json["label"],
    audio: json["audio"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "audio": audio,
  };
}

class MicroConcept {
  MicroConcept({
    this.id,
    this.label,
  });

  String id;
  String label;

  factory MicroConcept.fromJson(Map<String, dynamic> json) => MicroConcept(
    id: json["id"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
  };
}

class Option {
  Option({
    this.feedback,
    this.score,
    this.label,
    this.media,
    this.value,
    this.isCorrect,
  });

  List<Feedback> feedback;
  int score;
  String label;
  dynamic media;
  int value;
  int isCorrect;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    feedback: List<Feedback>.from(json["feedback"].map((x) => Feedback.fromJson(x))),
    score: json["score"],
    label: json["label"],
    media: json["media"],
    value: json["value"],
    isCorrect: json["isCorrect"],
  );

  Map<String, dynamic> toJson() => {
    "feedback": List<dynamic>.from(feedback.map((x) => x.toJson())),
    "score": score,
    "label": label,
    "media": media,
    "value": value,
    "isCorrect": isCorrect,
  };
}

class Feedback {
  Feedback({
    this.text,
    this.media,
  });

  String text;
  dynamic media;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    text: json["text"],
    media: json["media"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "media": media,
  };
}

class StyleClass {
  StyleClass();

  factory StyleClass.fromJson(Map<String, dynamic> json) => StyleClass(
  );

  Map<String, dynamic> toJson() => {
  };
}

class QuestionMetadata {
  QuestionMetadata({
    this.templateReference,
    this.name,
  });

  String templateReference;
  String name;

  factory QuestionMetadata.fromJson(Map<String, dynamic> json) => QuestionMetadata(
    templateReference: json["template_reference"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "template_reference": templateReference,
    "name": name,
  };
}

class QuestionSolution {
  QuestionSolution({
    this.data,
    this.answer,
    this.stepNav,
    this.type,
  });

  List<dynamic> data;
  String answer;
  bool stepNav;
  String type;

  factory QuestionSolution.fromJson(Map<String, dynamic> json) => QuestionSolution(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    answer: json["answer"],
    stepNav: json["step_nav"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "answer": answer,
    "step_nav": stepNav,
    "type": type,
  };
}

class Style {
  Style({
    this.qStyle,
    this.userInteraction,
  });

  QStyle qStyle;
  UserInteraction userInteraction;

  factory Style.fromJson(Map<String, dynamic> json) => Style(
    qStyle: QStyle.fromJson(json["qStyle"]),
    userInteraction: UserInteraction.fromJson(json["userInteraction"]),
  );

  Map<String, dynamic> toJson() => {
    "qStyle": qStyle.toJson(),
    "userInteraction": userInteraction.toJson(),
  };
}

class QStyle {
  QStyle({
    this.bg,
  });

  String bg;

  factory QStyle.fromJson(Map<String, dynamic> json) => QStyle(
    bg: json["bg"],
  );

  Map<String, dynamic> toJson() => {
    "bg": bg,
  };
}

class UserInteraction {
  UserInteraction({
    this.stylePrint,
    this.stylePreview,
    this.styleReview,
    this.styleAttempt,
  });

  String stylePrint;
  String stylePreview;
  String styleReview;
  String styleAttempt;

  factory UserInteraction.fromJson(Map<String, dynamic> json) => UserInteraction(
    stylePrint: json["stylePrint"],
    stylePreview: json["stylePreview"],
    styleReview: json["styleReview"],
    styleAttempt: json["styleAttempt"],
  );

  Map<String, dynamic> toJson() => {
    "stylePrint": stylePrint,
    "stylePreview": stylePreview,
    "styleReview": styleReview,
    "styleAttempt": styleAttempt,
  };
}
