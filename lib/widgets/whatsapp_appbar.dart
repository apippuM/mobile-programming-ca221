import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/colors/colors.dart';
import 'package:whatsapp_clone_app/widgets/whatsapp_icons.dart';

class WhatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WhatsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: WhatsAppColors.appBarColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('WhatsApp',
              style: TextStyle(
                color: WhatsAppColors.white
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              WhatsAppIcons(
                icon: Icons.camera_alt_outlined,
                right: 20,
                color: WhatsAppColors.white,
                ontap: () {},
              ),
              WhatsAppIcons(
                icon: Icons.search,
                right: 20,
                color: WhatsAppColors.white,
                ontap: () {},
              ),
              WhatsAppIcons(
                icon: Icons.more_vert,
                right: 20,
                color: WhatsAppColors.white,
                ontap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}