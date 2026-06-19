import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Демо-оплата в стиле Kaspi (без реального банковского API).
class KaspiPaymentDialog extends StatefulWidget {
  final String planName;
  final String amountLabel;
  final Color accentColor;

  const KaspiPaymentDialog({
    super.key,
    required this.planName,
    required this.amountLabel,
    this.accentColor = const Color(0xFFF14635),
  });

  static Future<bool?> show(
    BuildContext context, {
    required String planName,
    required String amountLabel,
    Color accentColor = const Color(0xFFF14635),
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => KaspiPaymentDialog(
        planName: planName,
        amountLabel: amountLabel,
        accentColor: accentColor,
      ),
    );
  }

  @override
  State<KaspiPaymentDialog> createState() => _KaspiPaymentDialogState();
}

class _KaspiPaymentDialogState extends State<KaspiPaymentDialog> {
  final _cardCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  bool _processing = false;
  String? _error;

  @override
  void dispose() {
    _cardCtrl.dispose();
    _expCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  bool get _valid {
    final card = _cardCtrl.text.replaceAll(' ', '');
    return card.length >= 16 &&
        _expCtrl.text.length >= 5 &&
        _cvvCtrl.text.length >= 3;
  }

  Future<void> _pay() async {
    if (!_valid) {
      setState(() => _error = 'Проверь номер карты, срок и CVV');
      return;
    }
    setState(() {
      _processing = true;
      _error = null;
    });
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              decoration: BoxDecoration(
                color: widget.accentColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Kaspi',
                      style: TextStyle(
                        color: widget.accentColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _processing
                        ? null
                        : () => Navigator.of(context).pop(false),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Оплата ${widget.planName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F1F1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.amountLabel,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFF14635),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Демо-режим: деньги не списываются',
                    style: TextStyle(fontSize: 11, color: Color(0xFF8EAEAC)),
                  ),
                  const SizedBox(height: 16),
                  _field(
                    controller: _cardCtrl,
                    label: 'Номер карты',
                    hint: '0000 0000 0000 0000',
                    keyboard: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      _CardNumberFormatter(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _field(
                          controller: _expCtrl,
                          label: 'Срок',
                          hint: 'MM/YY',
                          keyboard: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            _ExpiryFormatter(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _field(
                          controller: _cvvCtrl,
                          label: 'CVV',
                          hint: '•••',
                          obscure: true,
                          keyboard: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      _error!,
                      style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _processing || !_valid ? null : _pay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.accentColor,
                        disabledBackgroundColor:
                            widget.accentColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _processing
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Оплатить',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboard,
    List<TextInputFormatter>? inputFormatters,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A3332),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Color(0xFF0F1F1E), fontWeight: FontWeight.w600),
          onChanged: (_) => setState(() => _error = null),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF6B8A88)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB8E8E6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB8E8E6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0ABDB9), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buf.write(' ');
      buf.write(digits[i]);
    }
    final t = buf.toString();
    return TextEditingValue(
      text: t,
      selection: TextSelection.collapsed(offset: t.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 4) digits = digits.substring(0, 4);
    String t;
    if (digits.length <= 2) {
      t = digits;
    } else {
      t = '${digits.substring(0, 2)}/${digits.substring(2)}';
    }
    return TextEditingValue(
      text: t,
      selection: TextSelection.collapsed(offset: t.length),
    );
  }
}
