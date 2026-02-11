import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaSwitch extends StatelessWidget {
  final VoidCallback onTap;

  const BlaSwitch({super.key,required this.onTap});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.swap_vert,color:BlaColors.switchIcon)
    );
  }
}