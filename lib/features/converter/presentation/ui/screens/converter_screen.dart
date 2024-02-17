import 'package:currency_converter/di/dependency_init.dart';
import 'package:currency_converter/features/converter/presentation/blocs/currency_converter_bloc/currency_converter_bloc.dart';
import 'package:currency_converter/features/converter/presentation/blocs/fetch_currencies_cubit/fetch_currencies_cubit.dart';
import 'package:currency_converter/features/converter/presentation/ui/widgets/convert_form.dart';
import 'package:currency_converter/utils/app_router/routes_name.dart';
import 'package:currency_converter/utils/constants/app_strings.dart';
import 'package:currency_converter/widgets/custom_loading_indicator.dart';
import 'package:currency_converter/widgets/error_widget_with_try_again_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.currencyConverter)),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<FetchCurrenciesCubit>()..fetchCurrencies()),
          BlocProvider(create: (context) => getIt<CurrencyConverterBloc>()),
        ],
        child: BlocBuilder<FetchCurrenciesCubit, FetchCurrenciesState>(
          builder: (context, state) {
            return state.when(
              loading: () => const CustomLoadingIndicator(),
              success: (currencies) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const ConvertForm(),
                    const Spacer(flex: 5),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, RoutesName.historyScreen),
                      child: const Text(AppStrings.history),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              failure: (error) => ErrorWidgetWithTryAgainButton(
                errorMsg: error,
                onTryAgain: context.read<FetchCurrenciesCubit>().fetchCurrencies,
              ),
            );
          },
        ),
      ),
    );
  }
}
