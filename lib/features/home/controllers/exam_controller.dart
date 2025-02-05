import 'package:get/get.dart';

import '../../../data/repository/home/home_repository.dart';
import '../../../data/repository/test/test_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../screens/test/test.dart';
import 'home_controller.dart';

class ExamController extends GetxController {
  static ExamController get instance => Get.find();

  final testRepository = TestRepository.instance;
  final homeRepository = HomeRepository.instance;
  final homeController = HomeController.instance;
  String? selectedSubject;
  String? selectedLanguage;
  final examType = 'ҰБТ'.obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loading.value = true;
    examType.value = Get.arguments as String;
    loading.value = false;
  }

  final List<String> ubtSubjects = [
    "Қазақстан тарихы",
    "Математикалық сауаттылық",
    "Математика",
    "Информатика",
    "Физика",
    "Химия",
    "Биология",
    "География",
    "Ағылшын тілі",
    "Дүние жүзі тарихы",
    "Құқық негіздері",
    "Қазақ тілі",
    "Қазақ әдебиеті",
    "Орыс тілі",
    "Орыс әдебиеті",
  ];

  final List<String> pbbSubjects = [
    "Бейіні бойынша тәрбие мен оқыту әдістемесі, Мектепке дейінгі педагогика және психология",
    "Ағылшын тілі",
    "Биология",
    "География",
    "Графика және жобалау (Сызу)",
    "Информатика",
    "Тарих (Қазақстан тарихы/Дүниежүзі тарихы)",
    "Қазақ тілі мен әдебиеті",
    "Оқыту қазақ тілінде жүргізілмейтін сыныптар үшін «Қазақ тілі мен әдебиеті»",
    "Математика",
    "Музыка",
    "Алғашқы әскери және технологиялық дайындық",
    "Бастауыш сынып",
    "Неміс тілі",
    "Құқық негіздері",
    "Экономика және қаржылық сауаттылық негіздері",
    "Педагог психологтарға арналған психология",
    "Орыс тілі мен әдебиеті",
    "Оқыту орыс тілінде жүргізілмейтін сыныптар үшін «Орыс тілі мен әдебиеті»",
    "Зайырлылық және дінтану негіздері",
    "Әлеуметтік педагогика",
    "Тәжік тілі",
    "Өзбек тілі",
    "Ұйғыр тілі",
    "Физика",
    "Дене шынықтыру",
    "Француз тілі",
    "Химия",
    "Көркем еңбек (қыз балаларға арналған)",
    "Көркем еңбек (ұл балаларға арналған)",
    "Дефектология (Олигофренопедагогика)",
    "Логопедия",
    "Сурдопедагогика",
    "Тифлопедагогика",
    "Педагогика және психология негіздері",
  ];

  final List<String> languages = ["Қазақша", "Орысша"];

  void startQuiz() async {
    if (selectedSubject == null || selectedLanguage == null) {
      return;
    }

    try {
      TFullScreenLoader.openLoadingDialog('Сізге тест құрастырып жатырмыз', TImages.loading);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      int single = 0;
      int text = 0;
      int matched = 0;
      int multi = 0;
      if (examType.value == 'ҰБТ') {
        if (selectedSubject == 'Қазақстан тарихы') {
          single = 10;
          text = 2;
          matched = 0;
          multi = 0;
        } else if (selectedSubject == 'Математикалық сауаттылық') {
          single = 10;
          text = 0;
          matched = 0;
          multi = 0;
        } else {
          if (selectedSubject == 'Ағылшын тілі' || selectedSubject == 'Қазақ тілі' || selectedSubject == 'Қазақ әдебиеті' || selectedSubject == 'Орыс тілі' || selectedSubject == 'Орыс тілі') {
            selectedLanguage = 'Қазақша';
          }
          single = 25;
          text = 1;
          matched = 5;
          multi = 5;
        }
      }
      else if (examType.value == 'ПББ') {
        if (selectedSubject == 'Ағылшын тілі' ||
            selectedSubject == 'Қазақ тілі мен әдебиеті' ||
            selectedSubject == 'Оқыту қазақ тілінде жүргізілмейтін сыныптар үшін «Қазақ тілі мен әдебиеті»' ||
            selectedSubject == 'Орыс тілі мен әдебиеті' ||
            selectedSubject == 'Оқыту орыс тілінде жүргізілмейтін сыныптар үшін «Орыс тілі мен әдебиеті»') {
          selectedLanguage = 'Қазақша';
        }
        if (selectedSubject == 'Оқыту қазақ тілінде жүргізілмейтін сыныптар үшін «Қазақ тілі мен әдебиеті»') {
          selectedSubject = 'Қазақ тілі мен әдебиеті';
        } else if (selectedSubject == 'Оқыту орыс тілінде жүргізілмейтін сыныптар үшін «Орыс тілі мен әдебиеті»') {
          selectedSubject = 'Орыс тілі мен әдебиеті';
        }
        single = 40;
        text = 2;
        matched = 0;
        multi = 0;
      }
      else {
        return;
      }
      if(homeController.user.value.iin == '010101500555'){
        examType.value = 'ҰБТ';
        selectedSubject = 'Математикалық сауаттылық';
        selectedLanguage = 'Қазақша';
        single = 5;
        text = 0;
        matched = 0;
        multi = 0;
      }
      final userPoint = int.parse(homeController.user.value.point);
      if (userPoint < 1) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          duration: 5,
          title: 'Сіздің тест тапсыру мүмкіндігіңіз қалмады',
          message: 'Мененджермен байланысыңыз',
        );
        return;
      }
      final questions = await testRepository.fetchTestQuestions(
        examType.value,
        selectedSubject!,
        selectedLanguage!,
        single: single,
        text: text,
        matched: matched,
        multi: multi,
      );
      TFullScreenLoader.stopLoading();
      if (questions == null) {
        TLoaders.warningSnackBar(
          duration: 5,
          title: 'Бұл пәннен база жоқ',
          message: 'Бұл пәннен база құрастырып жатырмыз, бірнеше күн күтіңіз немесе мененджерден сұраңыз',
        );
      } else {
        Get.to(() => const TestScreen(), arguments: questions);
        homeController.user.value.point = (userPoint - 1).toString();
        await homeRepository.updateUserPoint(homeController.user.value.point, homeController.user.value.id ?? '');
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Базада қате пайда болды!!', message: e.toString());
    }
  }
}
