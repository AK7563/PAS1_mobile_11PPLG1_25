import 'package:flutter/material.dart';

class myPopUp extends StatelessWidget {
  const myPopUp({
    super.key,
    required this.title,
    required this.content,
    required this.action,
    required this.onPress
  });
  final String title,content, action;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: onPress,
            child: Text(action)
        )
      ],
    );
  }
}
