import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final String name;
  final VoidCallback callback;
  button({required this.name, required this.callback});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 340,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text(name,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
