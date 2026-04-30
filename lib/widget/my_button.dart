import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  const myButton({
    required this.color,
    required this.title,
    required this.function,
  });

  final Color color;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        color: color,
        child: MaterialButton(
          minWidth: 200,
          height: 50,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          onPressed: () => function(),
        ),
      ),
    );
  }
}