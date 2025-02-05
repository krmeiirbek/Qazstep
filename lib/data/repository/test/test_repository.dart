import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/home/models/question/question_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class TestRepository extends GetxController {
  static TestRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _random = Random();

  Future<List<Question>?> fetchTestQuestions(String examType, String subject, String language, {int single = 10, int text = 0, int matched = 0, int multi = 0}) async {
    try {
      List<Question> questions = [];

      if (single > 0) {
        QuerySnapshot singleSnapshot = await _db
            .collection('questions')
            .where('examType', isEqualTo: examType)
            .where('subject', isEqualTo: subject)
            .where('language', isEqualTo: language)
            .where('type', isEqualTo: 'single_choice')
            .get();
        List<SingleChoiceQuestion> singleQuestions = singleSnapshot.docs.map((doc) => SingleChoiceQuestion.fromMap(doc.data() as Map<String, dynamic>)).toList();
        if (singleQuestions.isNotEmpty) {
          singleQuestions.shuffle(_random);
          questions.addAll(singleQuestions.take(single));
        }
      }

      if (text > 0) {
        QuerySnapshot textSnapshot = await _db
            .collection('questions')
            .where('examType', isEqualTo: examType)
            .where('subject', isEqualTo: subject)
            .where('language', isEqualTo: language)
            .where('type', isEqualTo: 'text_question')
            .get();
        List<TextQuestion> textQuestions = textSnapshot.docs.map((doc) => TextQuestion.fromMap(doc.data() as Map<String, dynamic>)).toList();
        if (textQuestions.isNotEmpty) {
          textQuestions.shuffle(_random);
          questions.addAll(textQuestions.take(text));
        }
      }

      if (matched > 0) {
        QuerySnapshot matchingSnapshot = await _db
            .collection('questions')
            .where('examType', isEqualTo: examType)
            .where('subject', isEqualTo: subject)
            .where('language', isEqualTo: language)
            .where('type', isEqualTo: 'matching')
            .get();
        List<MatchingQuestion> matchingQuestions = matchingSnapshot.docs.map((doc) => MatchingQuestion.fromMap(doc.data() as Map<String, dynamic>)).toList();
        if (matchingQuestions.isNotEmpty) {
          matchingQuestions.shuffle(_random);
          questions.addAll(matchingQuestions.take(matched));
        }
      }

      if (multi > 0) {
        QuerySnapshot multipleSnapshot = await _db
            .collection('questions')
            .where('examType', isEqualTo: examType)
            .where('subject', isEqualTo: subject)
            .where('language', isEqualTo: language)
            .where('type', isEqualTo: 'multiple_choice')
            .get();
        List<MultipleChoiceQuestion> multipleQuestions = multipleSnapshot.docs.map((doc) => MultipleChoiceQuestion.fromMap(doc.data() as Map<String, dynamic>)).toList();
        if (multipleQuestions.isNotEmpty) {
          multipleQuestions.shuffle(_random);
          questions.addAll(multipleQuestions.take(multi));
        }
      }

      return single + text + matched + multi == questions.length ? questions : null;
    } on FirebaseException catch (e) {
      throw TFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatExceptions();
    } on PlatformException catch (e) {
      throw TPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
