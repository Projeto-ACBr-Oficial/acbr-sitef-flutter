import 'package:flutter/material.dart';

class KeypadButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const KeypadButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFFE3F2FD);
    Color contentColor = Colors.black;

    if (text == "X") {
      buttonColor = const Color(0xFFF44336);
      contentColor = Colors.white;
    } else if (text == "<") {
      buttonColor = const Color(0xFFFFC107);
      contentColor = Colors.white;
    }

    return AspectRatio(
      aspectRatio: 1.16,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: contentColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onClick,
        child: Text(
          text == "<" ? "⌫" : text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onClick;

  const ActionButton({
    super.key,
    required this.label,
    required this.color,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        onPressed: onClick,
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
