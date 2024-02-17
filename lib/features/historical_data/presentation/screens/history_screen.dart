import 'package:currency_converter/di/dependency_init.dart';
import 'package:currency_converter/features/historical_data/presentation/history_cubit/history_cubit.dart';
import 'package:currency_converter/utils/constants/app_strings.dart';
import 'package:currency_converter/widgets/custom_loading_indicator.dart';
import 'package:currency_converter/widgets/error_widget_with_try_again_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.history)),
      body: BlocProvider(
        create: (context) => getIt<HistoryCubit>()..fetchHistory(),
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            return state.when(
              loading: () => const CustomLoadingIndicator(),
              success: (results) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    AppStrings.historyText,
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                  ),
                  for (final item in results) Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${item.keys.first}: ${item.values.first.values.first}"),
                  ),
                ],
              ),
              failure: (error) => ErrorWidgetWithTryAgainButton(
                errorMsg: error,
                onTryAgain: context.read<HistoryCubit>().fetchHistory,
              ),
            );
          },
        ),
      ),
    );
  }
}
