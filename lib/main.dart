import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/agama_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/login_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/name_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/register_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/role_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/screens/class_creen/class_detail/class_detail_provider.dart';
import 'package:scout_hunt/screens/class_creen/manage_class/manage_class_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/pembina_game_list/pembina_game_list_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/siswa_game_list/siswa_game_list_provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/question_edit_screen/question_edit_provider.dart';
import 'package:scout_hunt/screens/play_screen/answer_screen/answer_provider.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_provider.dart';
import 'package:scout_hunt/screens/profile_screen/profile_provider.dart';
import 'package:scout_hunt/screens/sku_screen/sku_provider.dart';
import 'package:scout_hunt/screens/splash_screen/splash_provider.dart';
import 'package:scout_hunt/utils/supabase_db.dart';


void main() {
  SupabaseDb().initSupabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashProvider>(create: (context) => SplashProvider()),
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
        ChangeNotifierProvider<RegisterProvider>(create: (context) => RegisterProvider()),
        ChangeNotifierProvider<SkuProvider>(create: (context) => SkuProvider()),
        ChangeNotifierProvider<NameValidatorProvider>(create: (context) => NameValidatorProvider()),
        ChangeNotifierProvider<UsernameValidatorProvider>(create: (context) => UsernameValidatorProvider()),
        ChangeNotifierProvider<PasswordValidatorProvider>(create: (context) => PasswordValidatorProvider()),
        ChangeNotifierProvider<RoleValidatorProvider>(create: (context) => RoleValidatorProvider()),
        ChangeNotifierProvider<AgamaValidatorProvider>(create: (context) => AgamaValidatorProvider()),
        ChangeNotifierProvider<PembinaGameListProvider>(create: (context) => PembinaGameListProvider()),
        ChangeNotifierProvider<ProfileProvider>(create: (context) => ProfileProvider()),
        ChangeNotifierProvider<SiswaGameListProvider>(create: (context) => SiswaGameListProvider()),
        ChangeNotifierProvider<QuestionListProvider>(create: (context) => QuestionListProvider()),
        ChangeNotifierProvider<AnswerProvider>(create: (context) => AnswerProvider()),
        ChangeNotifierProvider<ManageClassProvider>(create: (context) => ManageClassProvider()),
        ChangeNotifierProvider<ClassDetailProvider>(create: (context) => ClassDetailProvider()),
        ChangeNotifierProvider<GameSetupProvider>(create: (context) => GameSetupProvider()),
        ChangeNotifierProvider<QuestionEditProvider>(create: (context) => QuestionEditProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scout Hunt",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      routes: Routes.routeMap,
    );
  }
}