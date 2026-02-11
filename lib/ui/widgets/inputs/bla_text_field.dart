import 'package:flutter/material.dart';

class BlaTextEditing extends StatelessWidget {
  final TextEditingController controller;

  const BlaTextEditing({super.key, required this.controller});

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Station Road or The Bridge Cafe',
        border: InputBorder.none
      ),
    );
  }
}