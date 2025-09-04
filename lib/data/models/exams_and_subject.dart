class Subject{
 final int subjectId;
 final String subjectName;

 Subject({required this.subjectId,required this.subjectName});

  factory Subject.fromJson(Map<String,dynamic> json){
    return  Subject(
        subjectId: json['subject_id'],
        subjectName: json['subject_name']
    );
  }
}

class Exam {
  final int examId;
  final String examName;
  final int totalSubjects;
  final int totalQuestions;
  final List<Subject> subjects;

  Exam({
    required this.examId,
    required this.examName,
    required this.totalSubjects,
    required this.totalQuestions,
    required this.subjects,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      examId: json['exam_id'],
      examName: json['exam_name'],
      totalSubjects: int.parse(json['total_subjects']),
      totalQuestions: int.parse(json['total_questions']),
      subjects: List<Subject>.from(
        json['subjects'].map((x) => Subject.fromJson(x)),
      ),
    );
  }
}