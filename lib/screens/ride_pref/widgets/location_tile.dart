import 'package:flutter/material.dart';
import '../../../ui/theme/theme.dart';
import '../../../model/ride/locations.dart';

class BlaLocationTile extends StatelessWidget{
  final Location location;
  final bool isHistory;
  final VoidCallback? onTap;

  const BlaLocationTile({super.key, required this.location, this.isHistory = false, required this.onTap});

  @override
  Widget build(BuildContext context){
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: isHistory ? Icon(Icons.history, color:BlaColors.iconLight) : null,
      title: Text(location.name, style: BlaTextStyles.label.copyWith(color:BlaColors.neutralDark)),
      subtitle: Text(location.country.name,style: BlaTextStyles.button.copyWith(color:BlaColors.neutralLight),),
      trailing: Icon(Icons.arrow_forward_ios, color:BlaColors.iconLight, size: 16,),
    );
  }
}