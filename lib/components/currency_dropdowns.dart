import 'package:currency_conv/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class FromCurrencyDropdown extends StatelessWidget {
  const FromCurrencyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    var fromState = Provider.of<FromCurrencyProvider>(context);

    return DropdownMenu(
      dropdownMenuEntries: [
        for (final currencyCode in supportedCodes.keys)
          DropdownMenuEntry(
            label: currencyCode,
            // '$currencyCode - ${supportedCodes[currencyCode]![0]} - ${supportedCodes[currencyCode]![1]}',
            value: currencyCode,
          )
      ],
      onSelected: (value) {
        fromState.change(value!);
      },
      width: 150,
      menuHeight: 50,
    );
  }
}

class ToCurrencyDropdown extends StatelessWidget {
  const ToCurrencyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    var toState = Provider.of<ToCurrencyProvider>(context);

    return DropdownMenu(
      dropdownMenuEntries: [
        for (final currencyCode in supportedCodes.keys)
          DropdownMenuEntry(
            label: currencyCode,
            // '$currencyCode - ${supportedCodes[currencyCode]![0]} - ${supportedCodes[currencyCode]![1]}',
            value: currencyCode,
          )
      ],
      onSelected: (value) {
        toState.change(value!);
      },
      width: 150,
      menuHeight: 50,
    );
  }
}
