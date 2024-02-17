import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/data/model/currency_model.dart';
import 'package:currency_converter/features/converter/data/dtos/currency_converter_dto.dart';
import 'package:currency_converter/features/converter/presentation/blocs/currency_converter_bloc/currency_converter_bloc.dart';
import 'package:currency_converter/features/converter/presentation/blocs/fetch_currencies_cubit/fetch_currencies_cubit.dart';
import 'package:currency_converter/utils/constants/app_strings.dart';
import 'package:currency_converter/widgets/error_widget_with_try_again_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertForm extends StatefulWidget {
  const ConvertForm({super.key});

  @override
  State<ConvertForm> createState() => _ConvertFormState();
}

class _ConvertFormState extends State<ConvertForm> {
  late List<CurrencyModel> _currencies;

  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;

  final _amountCont = TextEditingController();

  final _canUserEnterAmount = ValueNotifier(false);

  @override
  void initState() {
    _currencies = context.read<FetchCurrenciesCubit>().state.mapOrNull(success: (state) => state.currencies)!;
    super.initState();
  }

  @override
  void dispose() {
    _canUserEnterAmount.dispose();
    _amountCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<CurrencyModel>(
          decoration: const InputDecoration(label: Text(AppStrings.from)),
          items: [
            for (final item in _currencies)
              DropdownMenuItem(
                value: item,
                child: SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: item.flagUrl,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 4),
                      Expanded(child: Text(item.name)),
                    ],
                  ),
                ),
              ),
          ],
          onChanged: (currency) {
            _fromCurrency = currency;
            _checkIfUserCanEnterAmount();
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<CurrencyModel>(
          decoration: const InputDecoration(label: Text(AppStrings.to)),
          items: [
            for (final item in _currencies)
              DropdownMenuItem(
                value: item,
                child: SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: item.flagUrl,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 4),
                      Expanded(child: Text(item.name)),
                    ],
                  ),
                ),
              ),
          ],
          onChanged: (currency) {
            _toCurrency = currency;
            _checkIfUserCanEnterAmount();
          },
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder(
            valueListenable: _canUserEnterAmount,
            builder: (_, canUserEnterAmount, ___) {
              return TextField(
                readOnly: canUserEnterAmount == false,
                controller: _amountCont,
                decoration: InputDecoration(
                  label: const Text(AppStrings.amount),
                  filled: true,
                  fillColor: canUserEnterAmount ? Colors.transparent : Colors.grey.withOpacity(.5),
                ),
                onChanged: (_) => _convert(),
              );
            }),
        const SizedBox(height: 12),
        BlocBuilder<CurrencyConverterBloc, CurrencyConverterState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              success: (amount) => Text(
                amount.toStringAsFixed(3),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              failure: (error) => ErrorWidgetWithTryAgainButton(
                errorMsg: error,
                onTryAgain: _convert,
              ),
            );
          },
        ),
      ],
    );
  }

  void _checkIfUserCanEnterAmount() {
    if (_fromCurrency != null && _toCurrency != null && _canUserEnterAmount.value == false) {
      _canUserEnterAmount.value = true;
    } else if ((_fromCurrency == null || _toCurrency == null) && _canUserEnterAmount.value == true) {
      _canUserEnterAmount.value = false;
    } else if (_fromCurrency != null && _toCurrency != null) {
      _convert();
    }
  }

  void _convert() {
    final amount = double.tryParse(_amountCont.text.trim());
    if (amount != null) {
      context.read<CurrencyConverterBloc>().add(CurrencyConverterEvent.convert(
            CurrencyConverterDto(baseCurrency: _fromCurrency!.code, currencies: [_toCurrency!.code], amount: amount),
          ));
    }
  }
}
