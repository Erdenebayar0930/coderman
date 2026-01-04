import 'package:coderman/widgets/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/cpp.dart';

import '../theme/app_theme.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  final CodeController _codeController = CodeController(
    text: '''#include <iostream>
using namespace std;

int main() {
    // Энд өөрийн кодоо бичнэ үү

    return 0;
}''',
    language: cpp,
  );

  String outputText =
      'Кодыг ажиллуулж байна...\n\n'
      'Тест 1: ✓ Амжилттай\n'
      'Тест 2: ✓ Амжилттай\n'
      'Тест 3: ✓ Амжилттай\n\n'
      'Бүх тест амжилттай!';

  /* ⭐ NEW: Smart insert */
  void _insertSmart(String value) {
    final selection = _codeController.selection;
    final text = _codeController.text;

    if (value == '{') {
      _codeController.text = text.replaceRange(
        selection.start,
        selection.end,
        '{}',
      );
      _codeController.selection = TextSelection.collapsed(
        offset: selection.start + 1,
      );
      return;
    }

    if (value == 'TAB') {
      _codeController.text = text.replaceRange(
        selection.start,
        selection.end,
        '\t',
      );
      _codeController.selection = TextSelection.collapsed(
        offset: selection.start + 1,
      );
      return;
    }

    _codeController.text = text.replaceRange(
      selection.start,
      selection.end,
      value,
    );
    _codeController.selection = TextSelection.collapsed(
      offset: selection.start + value.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          /// MAIN CONTENT
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    const Icon(Icons.code, color: Colors.lightBlue),
                    const SizedBox(width: 8),
                    const Text(
                      'Хоёр тоо нэмэх',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: AppDecorations.card(context),
                      child: const Text(
                        'Амархан',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                const Text(
                  'Хоёр бүхэл тоо өгөгдөнө. Эдгээр тоонуудын нийлбэрийг олоорой.',
                ),

                const SizedBox(height: 16),

                const Text(
                  'C++ код:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                /// Code editor
                Container(
                  height: 460,
                  decoration: AppDecorations.card(context),
                  child: CodeTheme(
                    data: CodeThemeData(styles: AppTheme.devCppDark.styles),
                    child: CodeField(
                      controller: _codeController,
                      expands: true, // 👈 ЗӨВ
                      textStyle: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Гарц:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                /// Output
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    outputText,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
          ),

          /* ⭐ NEW: Keyboard Toolbar */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 56,
              decoration: AppDecorations.card(context),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _key('TAB'),
                          _key('if'),
                          _key('for'),
                          _key('{'),
                          _key(';'),
                          _key('('),
                          _key(')'),
                          _key('='),
                          _key('"'),
                          _key('\''),
                          _key(','),
                          _key('+'),
                          _key('-'),
                          _key('%'),
                          _key('!'),
                          _key('['),
                          _key(']'),
                          _key('#'),
                          _key('|'),
                          _key('&'),
                          _key('<'),
                          _key('>'),
                          _key('?'),
                          _key('^'),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        outputText = 'Кодыг ажиллуулж байна...\n\n✓ Амжилттай';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ⭐ NEW: Toolbar key */
  Widget _key(String text) {
    return InkWell(
      onTap: () => _insertSmart(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}
