import 'package:flutter/material.dart';
import 'package:scout_hunt/screens/auth_screen/login_screen/login_screen.dart';
import 'package:scout_hunt/screens/class_creen/class_detail/class_detail_screen.dart';
import 'package:scout_hunt/screens/class_creen/manage_class/manage_class_screen.dart';
import 'package:scout_hunt/screens/game_list_screen/pembina_game_list/pembina_game_list_screen.dart';
import 'package:scout_hunt/screens/game_list_screen/siswa_game_list/siswa_game_list_screen.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_screen.dart';
import 'package:scout_hunt/screens/game_setup_screen/question_edit_screen/question_edit_screen.dart';
import 'package:scout_hunt/screens/main_screen/offline_main_screen.dart';
import 'package:scout_hunt/screens/auth_screen/register_screen/register_screen.dart';
import 'package:scout_hunt/screens/main_screen/pembina_main_screen/pembina_main_screen.dart';
import 'package:scout_hunt/screens/main_screen/siswa_main_screem/siswa_main_screen.dart';
import 'package:scout_hunt/screens/materi_screen/materi_category_screen.dart';
import 'package:scout_hunt/screens/play_screen/answer_screen/answer_screen.dart';
import 'package:scout_hunt/screens/play_screen/game_result_screen.dart';
import 'package:scout_hunt/screens/play_screen/hunt_screen.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_screen.dart';
import 'package:scout_hunt/screens/profile_screen/profile_screen.dart';
import 'package:scout_hunt/screens/sku_screen/sku_screen.dart';
import 'package:scout_hunt/screens/splash_screen/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String classDetailScreen = '/class_detail';
  static const String materiCategoryScreen = '/category_materi';
  static const String offlineMainScreen = '/offline';
  static const String pembinaMainScreen = '/pembina';
  static const String pembinaGameListScreen = '/pembina/game_list';
  static const String pembinaGameSetupScreen = '/pembina/game_setup';
  static const String pembinaQuestionEditScreen = '/pembina/question_edit';
  static const String pembinaManageClassScreen = '/pembina/manage_class';
  static const String siswaMainScreen = '/siswa';
  static const String siswaSkuScreen = '/siswa/sku';
  static const String siswaProfileScreen = '/siswa/profile';
  static const String siswaGameListScreen = '/siswa/game_list';
  static const String siswaGameResultScreen = '/siswa/game_result';
  static const String siswaQuestionListScreen = '/siswa/question_list';
  static const String siswaHuntScreen = '/siswa/hunt';
  static const String siswaAnswerScreen = '/siswa/answer';

  static Map<String, WidgetBuilder> routeMap = {
    splashScreen: (context) => const SplashScreen(),
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    classDetailScreen: (context) => const ClassDetailScreen(),
    materiCategoryScreen: (context) => const MateriCategoryScreen(),
    offlineMainScreen: (context) => const OfflineMainScreen(),
    pembinaMainScreen: (context) => const PembinaMainScreen(),
    pembinaGameListScreen: (context) => const PembinaGameListScreen(),
    pembinaGameSetupScreen: (context) => GameSetupScreen(context: ModalRoute.of(context)!.settings.arguments as String),
    pembinaQuestionEditScreen: (context) => QuestionEditScreen(context: ModalRoute.of(context)!.settings.arguments as String),
    pembinaManageClassScreen: (context) => const ManageClassScreen(),
    siswaMainScreen: (context) => const SiswaMainScreen(),
    siswaSkuScreen: (context) => const SkuScreen(),
    siswaProfileScreen: (context) => const ProfileScreen(),
    siswaGameListScreen: (context) => const SiswaGameListScreen(),
    siswaQuestionListScreen: (context) => const QuestionListScreen(),
    siswaGameResultScreen: (context) => const GameResultScreen(),
    siswaHuntScreen: (context) => HuntScreen(ModalRoute.of(context)!.settings.arguments as int),
    siswaAnswerScreen: (context) => AnswerScreen(ModalRoute.of(context)!.settings.arguments as int),
  };
}
