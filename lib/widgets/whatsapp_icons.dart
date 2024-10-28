import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/colors/colors.dart';

class WhatsAppIcons extends StatelessWidget {
  final double? right;
  final IconData icon;
  final Color color;
  final VoidCallback ontap;

  const WhatsAppIcons(
    {this.right,
    required this.icon,
    required this.color,
    required this.ontap}
  );
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: right ?? 0.0),
      child: Material(
        color: WhatsAppColors.backgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: ontap,
          child: Icon(
            icon,
            color: color,
          ),
        ), 
      ),
    );
  }
}