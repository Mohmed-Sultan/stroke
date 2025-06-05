import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart'; // تأكد أن هذا المسار صحيح
import 'package:mohammed_ashraf/widgets/chat_bubble.dart'; // تأكد أن هذا المسار صحيح

// مثال لتعريف AppColors إذا لم يكن موجوداً في constants/app_colors.dart
// class AppColors {
//   static const Color primaryColor = Colors.teal; // أو أي لون أساسي لديك
//   static const Color lightBlue = Colors.lightBlueAccent; // أو أي لون لديك
// }

class ChatMessage {
  final String text;
  final bool isSender;
  ChatMessage({required this.text, required this.isSender});
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final messageText = _messageController.text.trim();
      setState(() {
        _messages.add(ChatMessage(text: messageText, isSender: true));
      });
      _messageController.clear();

      // Simulate bot response
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(text: "Okay, I received: '$messageText'", isSender: false));
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.smart_toy_outlined, color: AppColors.primaryColor),
            SizedBox(width: 8),
            Text('Chatbot'),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
              child: Text(
                'No messages yet. Start chatting!',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message.text,
                  isSender: message.isSender,
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: 'Message Chatbot...',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: () { /* TODO: Emoji picker */ },
                  color: Colors.grey[600],
                ),
                suffixIcon: IconButton(
                  // --- التغيير هنا ---
                  icon: const Icon(Icons.attach_file), // أيقونة مشبك الورق
                  onPressed: () { /* TODO: وظيفة إرفاق ملف */ },
                  color: Colors.grey[600],
                ),
                filled: true,
                fillColor: AppColors.lightBlue.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            onPressed: _sendMessage,
            backgroundColor: AppColors.primaryColor,
            elevation: 1,
            child: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}