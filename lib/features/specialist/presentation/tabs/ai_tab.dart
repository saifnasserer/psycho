import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubits/specialist_home_cubit.dart';

class AITab extends StatefulWidget {
  final SpecialistHomeState state;

  const AITab({super.key, required this.state});

  @override
  State<AITab> createState() => _AITabState();
}

class _AITabState extends State<AITab> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hello! I'm your AI assistant. How can I help you with your patients today?",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _generateAIResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _generateAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('patient') || message.contains('client')) {
      return "I can help you analyze patient data, suggest treatment approaches, or review clinical notes. What specific patient information would you like to discuss?";
    } else if (message.contains('treatment') || message.contains('therapy')) {
      return "Based on evidence-based practices, I can suggest treatment modalities. Could you provide more details about the patient's condition and current treatment plan?";
    } else if (message.contains('note') || message.contains('session')) {
      return "I can help you organize session notes, identify patterns in patient progress, and suggest areas for focus in upcoming sessions.";
    } else if (message.contains('schedule') ||
        message.contains('appointment')) {
      return "I can help you optimize your schedule, suggest appointment timing based on patient needs, and identify potential conflicts.";
    } else {
      return "I'm here to assist with patient care, treatment planning, clinical notes, and practice management. How can I help you today?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat Header
        Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border(
              bottom: BorderSide(color: Colors.grey[800]!, width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
                decoration: BoxDecoration(
                  color: const Color(
                    AppConstants.mintGreen,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 8),
                  ),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: const Color(AppConstants.mintGreen),
                  size: Responsive.getFontSize(context, 20),
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Assistant',
                      style: TextStyle(
                        fontSize: Responsive.getFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: Responsive.getFontSize(context, 12),
                        color: const Color(AppConstants.mintGreen),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Clear chat history
                },
                icon: Icon(
                  Icons.clear_all,
                  color: Colors.grey[400],
                  size: Responsive.getFontSize(context, 20),
                ),
              ),
            ],
          ),
        ),

        // Chat Messages
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return _buildMessageBubble(context, message);
            },
          ),
        ),

        // Message Input
        Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(
                      Responsive.getBorderRadius(context, 24),
                    ),
                    border: Border.all(color: Colors.grey[700]!, width: 1),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.getFontSize(context, 14),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ask me anything about your patients...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Responsive.getFontSize(context, 14),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Responsive.getSpacing(context, 16),
                        vertical: Responsive.getSpacing(context, 12),
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 8)),
              Container(
                decoration: BoxDecoration(
                  color: const Color(AppConstants.mintGreen),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 24),
                  ),
                ),
                child: IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: Responsive.getFontSize(context, 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.getSpacing(context, 12)),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: Responsive.getFontSize(context, 32),
              height: Responsive.getFontSize(context, 32),
              decoration: BoxDecoration(
                color: const Color(
                  AppConstants.mintGreen,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 16),
                ),
              ),
              child: Icon(
                Icons.bolt_rounded,
                color: const Color(AppConstants.mintGreen),
                size: Responsive.getFontSize(context, 16),
              ),
            ),
            SizedBox(width: Responsive.getSpacing(context, 8)),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.all(Responsive.getSpacing(context, 12)),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(AppConstants.mintGreen)
                    : const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.white,
                      fontSize: Responsive.getFontSize(context, 14),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 4)),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: message.isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : Colors.grey[500],
                      fontSize: Responsive.getFontSize(context, 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: Responsive.getSpacing(context, 8)),
            Container(
              width: Responsive.getFontSize(context, 32),
              height: Responsive.getFontSize(context, 32),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 16),
                ),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: Responsive.getFontSize(context, 16),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
