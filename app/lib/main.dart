import 'package:app/core/routes/router.dart';
import 'package:app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:app/features/habits/domain/cubit/habits_cubit.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

String appDocPath = "";

void main() async {
  await dotenv.load(fileName: ".env");
  appDocPath = (await getApplicationDocumentsDirectory()).path;
  await configureDependencies();
  await initializeDateFormatting('ru_RU');
  Intl.defaultLocale = 'ru_RU';

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<AuthCubit>()..loadMe(),
      ),
      BlocProvider(
        create: (context) => sl<HabitsCubit>()..getHabits(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = sl<AppRouter>();

    return MaterialApp.router(
      title: 'Boilerplate',
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.tealAccent,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.onestTextTheme().apply(bodyColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
          ),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        FormBuilderLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      locale: Locale('ru', 'RU'),
      routerConfig: appRouter.config(),
    );
  }
}
