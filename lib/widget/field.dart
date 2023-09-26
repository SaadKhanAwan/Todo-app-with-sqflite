import 'package:flutter/material.dart';

class field extends StatelessWidget {
  final String hint;
  final TextEditingController? contrl;
  final Icon? icoon;
  final type;
  field({required this.hint, this.icoon, this.contrl, this.type});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
          keyboardType: type,
          controller: contrl,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: icoon,
            filled: true,
            fillColor: Colors.grey,
            hintStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          )),
    );
  }
}
