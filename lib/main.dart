import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(title: const Text("App Bar")),
          body: const AppTextWidget("Hello World")),
    );
  }

}

class AppTextWidget extends StatelessWidget {
  final String text;
  const AppTextWidget(this.text,{super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: const Key('textWidgetKey'),
    );
  }

  // Method to validate text is not empty
  bool isValidText() {
    return text.isNotEmpty;
  }

  // Method to get text length
  int getTextLength() {
    return text.length;
  }

  // Method to check if text contains numbers
  bool containsNumbers() {
    return RegExp(r'[0-9]').hasMatch(text);
  }

  // Method to check if text contains special characters
  bool containsSpecialCharacters() {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text);
  }

  // Method to get word count
  int getWordCount() {
    if (!isValidText()) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  // Method to truncate text if it exceeds maxLength
  String getTruncatedText({int maxLength = 50}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Method to capitalize first letter of each word
  String getCapitalizedText() {
    if (!isValidText()) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  // Method to remove extra whitespace
  String getNormalizedText() {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

}

