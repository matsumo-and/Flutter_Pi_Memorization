import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pi_memorization/model/record/total_challenges_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/multiplication/multiplication_archivement.dart';
import 'model/pi_memorization/pi_archivement.dart';
import 'model/pi_memorization/pi_best_record.dart';
import 'view/bottom_tab_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //上向きのみを許可する。
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter<Multiplication>(MultiplicationAdopter());
  Hive.registerAdapter<TotalChallengesRecord>(TotalChallengesRecordAdopter());
  Hive.registerAdapter<PiArchivement>(PiArchivementAdopter());
  Hive.registerAdapter<PiBestRecord>(PiBestRecordAdopter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const Color canvasColor = Color.fromRGBO(236, 239, 241, 1);
  static const AppBarTheme appBarTheme = AppBarTheme(
    elevation: 1,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      title: 'Pi_Memorization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: appBarTheme,
        canvasColor: canvasColor,
        textTheme: TextTheme(
          headline1: GoogleFonts.notoSansJavanese(
            textStyle: const TextStyle(
              color: Color.fromRGBO(33, 33, 33, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline2: GoogleFonts.notoSansJavanese(
            textStyle: const TextStyle(
              color: Color.fromRGBO(33, 33, 33, 1),
              fontSize: 16,
            ),
          ),
          caption: GoogleFonts.notoSansJavanese(
            textStyle: const TextStyle(
              color: Color.fromRGBO(158, 158, 158, 1),
              fontSize: 14,
            ),
          ),
        ),
      ),
      home: const BottomTabBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
