import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:laraigo_chat/core/pages/chat_page.dart';

import '../../model/color_preference.dart';
import '../chat_socket.dart';

class SocketTextButton extends StatefulWidget {
  Widget child;
  String? integrationId;
  Color? circularProgressIndicatorColor;
  double? height;
  double? width;
  String customMessage;

  SocketTextButton(
      {required this.child,
      required this.integrationId,
      this.circularProgressIndicatorColor,
      this.width,
      this.customMessage = "",
      this.height});

  @override
  State<SocketTextButton> createState() => _SocketTextButtonState();
}

class _SocketTextButtonState extends State<SocketTextButton> {
  ChatSocket? socket;
  bool isInitialized = false;
  ColorPreference colorPreference = ColorPreference();

  @override
  void initState() {
    _initchatSocket();
    super.initState();
  }

  _initchatSocket() async {
    socket = await ChatSocket.getInstance(widget.integrationId!);
    colorPreference = socket!.integrationResponse!.metadata!.color!;
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      socket: socket!,
                      customMessage: widget.customMessage,
                    )));
      },
      child: isInitialized
          ? widget.child
          : Center(
              child: CircularProgressIndicator(
                color: widget.circularProgressIndicatorColor,
              ),
            ),
    );
  }
}
