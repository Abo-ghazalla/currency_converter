import 'package:currency_converter/features/converter/presentation/ui/screens/converter_screen.dart';
import 'package:currency_converter/features/historical_data/presentation/screens/history_screen.dart';
import 'package:currency_converter/utils/app_router/routes_name.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final appKey = GlobalKey<NavigatorState>();
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
      case RoutesName.convertScreen:
        return MaterialPageRoute(builder: (_) => const ConverterScreen());

      case RoutesName.historyScreen:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("no Views for that root")),
          );
        });
    }
  }

}
