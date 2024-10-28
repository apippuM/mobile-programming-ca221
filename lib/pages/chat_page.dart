import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/colors/colors.dart';
import 'package:whatsapp_clone_app/widgets/whatsapp_appbar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(),
        body: TabBarView(
          children: [
            Container(),
            Container(),
            Container(),
            //WhatsappChats(),
            //WhatsappStatus(),
            //WhatsappCalls,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.chat),
          backgroundColor: WhatsAppColors.tabFocusedColor,
          ),
      )
    );
  }
}