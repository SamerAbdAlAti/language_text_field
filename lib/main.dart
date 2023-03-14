import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Keyboard Language Demo',
      home: KeyboardLanguageDemo(),
    );
  }
}

class KeyboardLanguageDemo extends StatefulWidget {
  @override
  _KeyboardLanguageDemoState createState() => _KeyboardLanguageDemoState();
}

class _KeyboardLanguageDemoState extends State<KeyboardLanguageDemo> {
  final TextEditingController _textEditingController = TextEditingController();
  String _keyboardLanguage = '';

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _textEditingController.text;
    final keyboardLanguage = _getKeyboardLanguage(text);
    setState(() {
      _keyboardLanguage = keyboardLanguage;
    });
  }

  String _getKeyboardLanguage(String text) {
    if (text.isEmpty) {
      return '';
    }
    final firstChar = text.runes.first;
    if (isArabic(firstChar)) {
      return 'ar';
    } else {
      return 'en';
    }
  }

  bool isArabic(int codeUnit) {
    return (codeUnit >= 0x0600 && codeUnit <= 0x06FF) || // Arabic
        (codeUnit >= 0x0750 && codeUnit <= 0x077F) || // Arabic Supplement
        (codeUnit >= 0xFB50 && codeUnit <= 0xFDFF) || // Arabic Presentation Forms-A
        (codeUnit >= 0xFE70 && codeUnit <= 0xFEFF);   // Arabic Presentation Forms-B
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Keyboard Language Demo'),
      ),
      body: Column(
        children: [
          Text('Keyboard Language: $_keyboardLanguage'),
          TextField(
            controller: _textEditingController,
            textAlign: _getTextAlign(),
            decoration: const InputDecoration(
              hintText: 'Enter text here',
            ),
          ),
        ],
      ),
    );
  }

  TextAlign _getTextAlign() {
    if (_keyboardLanguage == 'ar') {
      return TextAlign.right;
    } else {
      return TextAlign.left;
    }
  }
}
