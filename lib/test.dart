import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:test_project/getTokens.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SearchableDropdownFormField<int>(
            backgroundDecoration: (child) => Card(
              margin: EdgeInsets.zero,
              color: Colors.red,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
            hintText: const Text('Search Anime'),
            margin: const EdgeInsets.all(15),
            items: List.generate(
                30,
                (i) => SearchableDropdownMenuItem(
                    value: i, label: 'item $i', child: Text('item $i'))),
            validator: (val) {
              if (val == null) return 'Cant be empty';
              return null;
            },
            onSaved: (val) {
              debugPrint('On save: $val');
            },
          ),
          ElevatedButton(
              onPressed: () {
                getTokens().getTokenDetails();
              },
              child: Text("tokens"))
        ],
      )),
    );
  }
}
