
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_prep_exam/core/theme/app_colors.dart';
import 'package:pocket_prep_exam/data/models/exams_and_subject.dart';
import 'package:pocket_prep_exam/data/models/question_model.dart';
import 'package:pocket_prep_exam/pages/questions/view/questions_view.dart';
import '../../edite_subjects/controller/edite_subject_controller.dart';
import '../../questions/control/questions_controller.dart';
import 'empty_state.dart';

class QuizResultTabView extends StatelessWidget {
  final Subject? subject;
  final Map<String, dynamic> quizResults;
  final List<Question> quizQuestions;
  const QuizResultTabView({
    super.key,
     this.subject,
    required this.quizResults,
    required this.quizQuestions
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();
    if (controller.questions.isEmpty) {
      controller.startQuiz();
    }
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            children: [
              _buildAll(controller),
              _buildFiltered(controller, quizResults['flagged'] ?? [], "Flagged"),
              _buildFiltered(controller, quizResults['incorrectQuestionIds'] ?? [], "Incorrect"),
              _buildFiltered(controller, quizResults['correctQuestionIds'] ?? [], "Correct"),
            ],
          ),
        ),
      ],
    );
  }
  void _navigateToQuizView(
      int initialPageIndex,
      String tabTitle,
      List<int> questionIdsToReview,
      Map<int, int> selectedOptions,
      String reviewType,
      ) {
    final questionsController = Get.find<QuestionController>();
    questionsController.setReviewQuestions(questionIdsToReview, selectedOptions);
    questionsController.flaggedQuestions.clear();
    List<int> filteredFlags = [];
    final originalFlaggedList = List<int>.from(quizResults['flagged'] as List? ?? []);
    for (int qId in questionIdsToReview) {
      if (originalFlaggedList.contains(qId)) {
        filteredFlags.add(qId);
      }
    }
    questionsController.flaggedQuestions.assignAll(filteredFlags);
    Get.to(() => QuizzesView(
      reviewMode: true,
      initialPage: initialPageIndex,
      tabTitle: tabTitle,
      questionIdsToReview: questionIdsToReview,
      selectedOptions: selectedOptions,
      reviewType: reviewType,
    ));
  }



  Widget _buildAll(QuestionController controller) {
    return Obx(() {
      if (controller.questions.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      final selectedOptionsMap = quizResults['selectedOptions'] as Map<int, int>? ?? {};
      final answeredQuestionIndices = selectedOptionsMap.keys.toList();
      answeredQuestionIndices.sort();
      if (answeredQuestionIndices.isEmpty) {
        return const Center(child: Text("No answered questions"));
      }
      final correctIds = quizResults['correctQuestionIds'] as List<int>? ?? [];
      final incorrectIds = quizResults['incorrectQuestionIds'] as List<int>? ?? [];
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: answeredQuestionIndices.length,
        itemBuilder: (context, index) {
          int qIndex = answeredQuestionIndices[index];
          if (qIndex >=   quizQuestions.length) return const SizedBox();
          final q = controller.questions[qIndex];
          final selectedOptionIndex = selectedOptionsMap[qIndex];
          bool isCorrect = false;
          if (selectedOptionIndex != null && selectedOptionIndex < q.options.length) {
            final selectedOption = q.options[selectedOptionIndex];
            isCorrect = _normalize(selectedOption) == _normalize(q.correctAnswer);
          }
          return _buildQuestionCard(
            // subject: subject.subjectId,
            q,
            qIndex,
            isCorrect: isCorrect,
            onTap: () {
              if (isCorrect) {
                _navigateToQuizView(
                    correctIds.indexOf(qIndex),
                    "Review Correct",
                    correctIds,
                    selectedOptionsMap,
                    "Correct"
                );
              } else {
                _navigateToQuizView(
                    incorrectIds.indexOf(qIndex),
                    "Review Incorrect",
                    incorrectIds,
                    selectedOptionsMap,
                    "Incorrect"
                );
              }
            },
          );
        },
      );
    });
  }

  Widget _buildFiltered(QuestionController controller, List<dynamic> ids, String type) {
    List<int> questionIds = [];
    for (var id in ids) {
      if (id is int) {
        questionIds.add(id);
      }
    }
    if (questionIds.isEmpty) {
      return EmptyStateWidget(type: type);
    }
    final selectedOptionsMap = quizResults['selectedOptions'] as Map<int, int>? ?? {};
    return Obx(() {
      if (controller.questions.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: questionIds.length,
        itemBuilder: (context, i) {
          int qIndex = questionIds[i];
          if (qIndex >= quizQuestions.length) return const SizedBox();
          final q = controller.questions[qIndex];
          final selectedOptionIndex = selectedOptionsMap[qIndex];
          bool isCorrect = false;
          if (selectedOptionIndex != null && selectedOptionIndex < q.options.length) {
            final selectedOption = q.options[selectedOptionIndex];
            isCorrect = _normalize(selectedOption) == _normalize(q.correctAnswer);
          }
          return _buildQuestionCard(
            q,
            qIndex,
            isCorrect: isCorrect,
            onTap: () {
              _navigateToQuizView(
                i,
                "Review $type",
                questionIds,
                selectedOptionsMap,
                type,
              );
            },
          );
        },
      );
    });
  }

  Widget _buildQuestionCard(Question question, int qIndex, {required bool isCorrect, required VoidCallback onTap}) {
    final selectedOptionIndex = quizResults['selectedOptions']?[qIndex];
    final flaggedList = quizResults['flagged'] as List<dynamic>? ?? [];
    final isFlagged = flaggedList.contains(qIndex);
    final subjectName =  Get.find<EditeSubjectController>().getSubjectNameById(question.subjectId);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: greyColor.withAlpha(100),
              width: 01.10,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subjectName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    children: [
                      if (isFlagged) ...[
                        const Icon(
                          Icons.flag_outlined,
                          color: Colors.orange,
                          size: 24,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                        size: 28,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                question.questionText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              if (selectedOptionIndex != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Answer:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        question.options[selectedOptionIndex],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (!isCorrect) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Correct Answer:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        question.correctAnswer,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _normalize(String text) {
    String cleanedText = text.trim();
    if (cleanedText.length > 1 && (cleanedText[1] == '.' || cleanedText[1] == ')' || cleanedText[1] == ':')) {
      return cleanedText[0].toUpperCase();
    }
    return cleanedText.toUpperCase();
  }
}