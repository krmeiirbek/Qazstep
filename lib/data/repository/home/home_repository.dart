import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/home/models/user/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';

class HomeRepository extends GetxController {
  static HomeRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  Future<void> uploadJsonToFirebase() async {
    const String jsonString = '''{
  "questions": [
      {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "2; 5; X ; У; 14; 17 берілген сандар қатарындағы заңдылықты анықтап, X*У көбейтіндісін табыңыз",
      "questionImage": null,
      "options": [
        "21",
        "88",
        "70",
        "19"
      ],
      "correctAnswer": "88"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "26; 36; 50; 66 сандарының ішінде әр түрлі үш жай санның көбейтіндісі түрінде жазылатын сан",
      "questionImage": null,
      "options": [
        "26",
        "50",
        "66",
        "36"
      ],
      "correctAnswer": "66"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "Төмендегі гистограммада көп қабатты үйлер және олардың биіктіктері (метрмен) көрсетілген.\\\\nГистограмманы пайдаланып, көп қабатты үйлер биіктігінің медианасын табыңыз", 
      "questionImage": "https://firebasestorage.googleapis.com/v0/b/qazstep-777.firebasestorage.app/o/questionImages%2F3.png?alt=media&token=e3039726-0a5a-4ad9-901e-75b69cfe10b2",
      "options": [
        "45 м",
        "40 м",
        "43 м",
        "37 м"
      ],
      "correctAnswer": "40 м"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "Еңбек өнімділігінің (у-өнім мөлшері) жұмыс уақытының ұзақтығына тәуелділігі (х-уақыт) у = 2 - х(x + 4) заңдылығымен өзгергендегі функция",
      "questionImage": null,
      "options": [
        "кубтық функция",
        "квадраттық функция",
        "көрсеткіштік функция",
        "сызықтық функция"
      ],
      "correctAnswer": "квадраттық функция"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "2; 5; X ; У; 14; 17 берілген сандар қатарындағы заңдылықты анықтап, X*У көбейтіндісін табыңыз",
      "questionImage": null,
      "options": [
        "21",
        "88",
        "70",
        "19"
      ],
      "correctAnswer": "88"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "26; 36; 50; 66 сандарының ішінде әр түрлі үш жай санның көбейтіндісі түрінде жазылатын сан",
      "questionImage": null,
      "options": [
        "26",
        "50",
        "66",
        "36"
      ],
      "correctAnswer": "66"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "Төмендегі гистограммада көп қабатты үйлер және олардың биіктіктері (метрмен) көрсетілген.\\\\nГистограмманы пайдаланып, көп қабатты үйлер биіктігінің медианасын табыңыз",
      "questionImage": "https://firebasestorage.googleapis.com/v0/b/qazstep-777.firebasestorage.app/o/questionImages%2F3.png?alt=media&token=e3039726-0a5a-4ad9-901e-75b69cfe10b2",
      "options": [
        "45 м",
        "40 м",
        "43 м",
        "37 м"
      ],
      "correctAnswer": "40 м"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "sin\\\\alpha=0,7\\\\ және 900 < α<1800 шарттарын ескере отырып cos2α-ның мәнін табыңыз",
      "questionImage": null,
      "options": [
        "0,02",
        "-0,02",
        "-0,14",
        "0,3"
      ],
      "correctAnswer": "0,02"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "\\\\sqrt{7+4\\\\sqrt3}\\\\ өрнегінің мәні",
      "questionImage": null,
      "options": [
        "2+\\\\sqrt2",
        "2+\\\\sqrt3",
        "1+\\\\sqrt3",
        "2-\\\\sqrt3"
      ],
      "correctAnswer": "2+\\\\sqrt3"
    },
    {
      "examType": "ҰБТ",
      "subject": "Математикалық сауаттылық",
      "language": "Қазақша",
      "type": "single_choice",
      "questionText": "\\\\frac{(\\\\frac{1}{4}m^2n)^3\\\\ast({-32m}^2n)}{-\\\\frac{1}{2}m^8n^4}",
      "questionImage": null,
      "options": [
        "m",
        "1",
        "mn",
        "n"
      ],
      "correctAnswer": "1"
    }
  ]
}''';

    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> questions = jsonData['questions'];

      final CollectionReference questionsCollection = FirebaseFirestore.instance.collection('questions');

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (var question in questions) {
        DocumentReference docRef = questionsCollection.doc();
        batch.set(docRef, question);
      }
      await batch.commit();
      print('JSON questions uploaded successfully!');
    } catch (e) {
      print('Error uploading JSON: $e');
    }
  }

  Future<void> saveUserRecord(UserModel user) async {
    try {
      var userRef = _db.collection("Users").doc(user.id);
      var doc = await userRef.get();
      if (doc.exists) {
        return;
      }
      var userData = user.toJson();
      userData['lastUpdated'] = DateTime.now();

      await _db.collection("Users").doc(user.id).set(userData);
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

  Future<void> saveUserRecordCredentials(UserCredential? userCredentials, String iin, String password) async {
    try {
      if (userCredentials != null) {
        final user = UserModel(
          id: userCredentials.user?.uid,
          iin: iin,
          password: password,
          point: '1',
        );

        await saveUserRecord(user);
      }
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

  Future<void> updateUserPoint(String point, String userId) async {
    try {
      await _db.collection("Users").doc(userId).update({"point": point});
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
