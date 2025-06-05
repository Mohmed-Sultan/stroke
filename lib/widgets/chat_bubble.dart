import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: isSender ? AppColors.primaryColor : AppColors.lightBlue,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
            bottomLeft: Radius.circular(isSender ? 16.0 : 0),
            bottomRight: Radius.circular(isSender ? 0 : 16.0),
          ),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? Colors.white : AppColors.textColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}