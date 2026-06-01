import 'package:flutter/material.dart';

import '../../services/neuron_ai_service.dart';

class NeuronChatSheet extends StatefulWidget {
  final String languageName;
  final String chapterTitle;
  final bool isKids;
  final String? theorySnippet;

  const NeuronChatSheet({
    super.key,
    required this.languageName,
    required this.chapterTitle,
    this.isKids = false,
    this.theorySnippet,
  });

  static Future<void> open(
    BuildContext context, {
    required String languageName,
    required String chapterTitle,
    bool isKids = false,
    String? theorySnippet,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NeuronChatSheet(
        languageName: languageName,
        chapterTitle: chapterTitle,
        isKids: isKids,
        theorySnippet: theorySnippet,
      ),
    );
  }

  @override
  State<NeuronChatSheet> createState() => _NeuronChatSheetState();
}

class _NeuronChatSheetState extends State<NeuronChatSheet> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();
  final _messages = <_ChatMsg>[
    _ChatMsg(
      fromNeuron: true,
      text: 'Я Нейрончик 🧠 Спроси про эту главу — помогу!',
    ),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();
    setState(() {
      _messages.add(_ChatMsg(fromNeuron: false, text: text));
    });
    final answer = NeuronAiService.instance.reply(
      userMessage: text,
      languageName: widget.languageName,
      chapterTitle: widget.chapterTitle,
      isKids: widget.isKids,
      theorySnippet: widget.theorySnippet,
    );
    setState(() {
      _messages.add(_ChatMsg(fromNeuron: true, text: answer));
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.62,
        decoration: const BoxDecoration(
          color: Color(0xFF0F1F1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
              child: Row(
                children: [
                  const Text('🧠', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Нейрончик',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.chapterTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8EAEAC),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white54),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF1A3332), height: 1),
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final m = _messages[i];
                  return Align(
                    alignment: m.fromNeuron
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.78,
                      ),
                      decoration: BoxDecoration(
                        color: m.fromNeuron
                            ? const Color(0xFF1A3332)
                            : const Color(0xFF0ABDB9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        m.text,
                        style: TextStyle(
                          color: m.fromNeuron
                              ? Colors.white
                              : const Color(0xFF0F1F1E),
                          fontSize: 14,
                          height: 1.35,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Спроси Нейрончика…',
                        hintStyle: const TextStyle(color: Color(0xFF5A7A78)),
                        filled: true,
                        fillColor: const Color(0xFF1A3332),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _send,
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF0ABDB9),
                    ),
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMsg {
  final bool fromNeuron;
  final String text;
  const _ChatMsg({required this.fromNeuron, required this.text});
}
