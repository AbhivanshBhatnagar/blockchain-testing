import 'package:flutter/material.dart';
import 'package:test_project/presentation/main/home/widgets/symbol_button.dart';

import 'widgets/account_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AccountCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SymbolButton(),
                SymbolButton(),
                SymbolButton(),
              ],
            ),
          ),
          Divider(),

        ],
      ),
    );
  }
}
