import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum BlaButtonType {
  primary(BlaColors.primaryButtonColor),
  secondary(BlaColors.secondaryButtonColor);

  final Color color;

  const BlaButtonType(this.color);
}
class BlaButton extends StatelessWidget {
  final String label;
  final BlaButtonType type;
  final IconData? icon;
  final VoidCallback onPressed;

  final double padding;     
  final double radius;       

  const BlaButton({
    super.key,
    required this.label,
    this.type = BlaButtonType.primary,
    this.icon,
    required this.onPressed,
    this.padding = BlaSpacings.m,
    this.radius = 0,
  });

  Color get color {
    switch (type) {
      case BlaButtonType.primary:
        return BlaColors.white;
      case BlaButtonType.secondary:
        return BlaColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: type.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(vertical: padding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: color),
          if (icon != null) SizedBox(width: BlaSpacings.s),
          Text(
            label,
            style: BlaTextStyles.button.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}




