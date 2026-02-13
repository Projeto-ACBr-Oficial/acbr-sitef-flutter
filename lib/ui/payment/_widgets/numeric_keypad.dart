import 'package:flutter/material.dart';

import 'keypad_button.dart';

class NumericKeypad extends StatelessWidget {
  final Function(int) onNumberClick;
  final VoidCallback onDeleteClick;
  final VoidCallback onClearClick;

  const NumericKeypad({
    super.key,
    required this.onNumberClick,
    required this.onDeleteClick,
    required this.onClearClick,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "X",
      "0",
      "<",
    ];

    return Column(
      children: [
        for (var i = 0; i < keys.length; i += 3)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: keys.sublist(i, i + 3).map((key) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: KeypadButton(
                      text: key,
                      onClick: () {
                        if (key == "X") {
                          onClearClick();
                        } else if (key == "<") {
                          onDeleteClick();
                        } else {
                          onNumberClick(int.parse(key));
                        }
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
