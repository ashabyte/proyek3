import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_widgets.dart';

class ChatbotAiScreen extends StatefulWidget {
  const ChatbotAiScreen({super.key});

  @override
  State<ChatbotAiScreen> createState() => _ChatbotAiScreenState();
}

class _ChatbotAiScreenState extends State<ChatbotAiScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: "Good morning! We're from Denio Imagine Yearbook, how may I help you?",
      isUser: false,
    ),
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _msgCtrl.clear();
    });

    _scrollToBottom();

    // Simulasi balasan AI
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _messages.add(_ChatMessage(
          text:
              'Terima kasih sudah menghubungi kami! Tim Denio Imagine akan segera membantu Anda. 😊',
          isUser: false,
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'ChatBot AI',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── Chat Messages ─────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _BubbleTile(message: msg);
              },
            ),
          ),

          // ── Input Box ─────────────────────────────────────────────
          _ChatInputBox(
            controller: _msgCtrl,
            onSend: _sendMessage,
            onAttach: () {
              // TODO: image picker
            },
          ),
        ],
      ),
    );
  }
}

// ── Data class ──────────────────────────────────────────────────────────────
class _ChatMessage {
  final String text;
  final bool isUser;
  final bool hasImage;

  const _ChatMessage({
    required this.text,
    required this.isUser,
    this.hasImage = false,
  });
}

// ── Chat Bubble ─────────────────────────────────────────────────────────────
class _BubbleTile extends StatelessWidget {
  final _ChatMessage message;
  const _BubbleTile({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.surface : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          border: Border.all(
            color: isUser ? AppColors.border : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textPrimary,
            height: 1.55,
          ),
        ),
      ),
    );
  }
}

// ── Input Box ────────────────────────────────────────────────────────────────
class _ChatInputBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  const _ChatInputBox({
    required this.controller,
    required this.onSend,
    required this.onAttach,
  });

  @override
  State<_ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<_ChatInputBox> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final hasText = widget.controller.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _hasText ? AppColors.primary : AppColors.border,
          width: _hasText ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Attach button
          GestureDetector(
            onTap: widget.onAttach,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6, right: 8),
              child: Icon(
                Icons.add,
                size: 22,
                color: AppColors.textHint,
              ),
            ),
          ),

          // Text field
          Expanded(
            child: TextField(
              controller: widget.controller,
              maxLines: 5,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                hintStyle: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textHint,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          GestureDetector(
            onTap: _hasText ? widget.onSend : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _hasText ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}