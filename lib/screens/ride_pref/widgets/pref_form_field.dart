import 'package:flutter/material.dart';
import '../../../ui/theme/theme.dart';
import '../../../ui/widgets/actions/bla_switch.dart';

class BlaPrefFormField extends StatelessWidget{
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onTrailingTap;

  const BlaPrefFormField({super.key, this.icon = Icons.circle_outlined ,required this.label, required this.onTap, this.onTrailingTap});

  @override
  Widget build(BuildContext context){
    return ListTile(
      onTap:onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      leading: Icon(icon, color:BlaColors.iconLight),
      title: Text(label, style: BlaTextStyles.label.copyWith(color:BlaColors.textLight)),
      trailing: onTrailingTap != null ? BlaSwitch(onTap: onTrailingTap!) : null,
    );
  }
}