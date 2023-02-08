// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../helpers/color_convert.dart';
import '../../model/color_preference.dart';
import '../../model/message_response.dart';
import '../chat_socket.dart';

/*
Message Widget for Button MessageType
 */
class MessageButtons extends StatelessWidget {
  List<MessageResponseData> data;
  final ChatSocket _socket;
  ColorPreference color;

  MessageButtons(this.data, this.color, this._socket, {super.key});

  sendMessage(String text, String title) async {
    var messageSent = await ChatSocket.sendMessage(text, title);
    _socket.controller!.sink.add(messageSent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Text(
            data[0].message!,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: HexColor(color.messageBotColor.toString())
                            .computeLuminance() >
                        0.5
                    ? Colors.black
                    : Colors.white),
          ),
        ),
        
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.transparent),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data[0].buttons!.length,
            itemBuilder: (context, indx) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(color.messageClientColor !),
                    ),
                    onPressed: () {
                      sendMessage(data[0].buttons![indx].payload!,
                          data[0].buttons![indx].text!);
                    },
                    child: Text(
                      data[0].buttons![indx].text!,
                      style: TextStyle(
                          color: HexColor(color.messageClientColor.toString())
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white),
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }
}
