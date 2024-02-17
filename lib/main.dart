import 'package:currency_converter/di/dependency_init.dart';
import 'package:currency_converter/utils/app_router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
      ),
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.appKey,
      scaffoldMessengerKey: AppRouter.scaffoldKey,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
