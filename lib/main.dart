import 'package:assignments/commons_functions/common_functions.dart';
import 'package:assignments/database_helper/local_list_helper.dart';
import 'package:assignments/resources/app_colors.dart';
import 'package:assignments/resources/global_context_service.dart';
import 'package:assignments/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  /// to ensure the binding of other systems in debug mode
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize isar database
  await LocalDatabase.initialize();

  /// set portrait orientation for mobile app permanently
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  CommonFunctions.lightStatusBarColor(AppColors.amber);
  runApp(
    /// Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.amber),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.appBackgroundColor,
      ),
      initialRoute: '/todo_screen',
      routes: namedRoutes,
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
