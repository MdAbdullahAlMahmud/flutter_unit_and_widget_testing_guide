import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_tesing/main.dart';

/**
 * Created by Abdullah on 27/1/25.
 */

void main() {
  // Constructor tests
  group('constructor', () {
    testWidgets('should create widget with provided text',
        (WidgetTester tester) async {
      const text = 'Hello Flutter';
      await tester.pumpWidget(const MaterialApp(home: AppTextWidget(text)));
      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should create widget with empty text',
        (WidgetTester tester) async {
      const text = '';
      await tester.pumpWidget(const MaterialApp(home: AppTextWidget(text)));
      expect(find.text(text), findsOneWidget);
    });
  });

  // Theme tests
  group('theme integration', () {
    testWidgets('should inherit text color from theme in light mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const AppTextWidget('Test'),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, null); // Should inherit from theme
    });

    testWidgets('should inherit text color from theme in dark mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const AppTextWidget('Test'),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, null); // Should inherit from theme
    });

    testWidgets('should maintain contrast in both themes',
        (WidgetTester tester) async {
      // Test light theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(body: AppTextWidget('Test')),
        ),
      );

      Text textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, null);

      // Test dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const Scaffold(body: AppTextWidget('Test')),
        ),
      );

      textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, null);
    });
  });

  // Error cases and edge cases
  group('error cases', () {
    testWidgets('should handle extremely long text without crashing',
        (WidgetTester tester) async {
      final longText = 'A' * 10000; // Very long text
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextWidget(longText),
          ),
        ),
      );
      expect(find.text(longText), findsOneWidget);
    });

    testWidgets('should handle special characters without breaking layout',
        (WidgetTester tester) async {
      const specialChars = '!@#\$%^&*()_+{}[]|":;<>?~`';
      await tester
          .pumpWidget(const MaterialApp(home: AppTextWidget(specialChars)));
      expect(find.text(specialChars), findsOneWidget);
    });

    testWidgets('should handle mixed unicode characters',
        (WidgetTester tester) async {
      const mixedText = 'Hello 世界 🌍 مرحبا';
      await tester
          .pumpWidget(const MaterialApp(home: AppTextWidget(mixedText)));
      expect(find.text(mixedText), findsOneWidget);
    });
  });

  // Overflow tests
  group('text overflow', () {
    testWidgets('should handle text overflow in constrained width',
        (WidgetTester tester) async {
      const longText =
          'This is a very long text that should definitely overflow in a constrained width container';
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(
            width: 100, // Constrained width
            child: AppTextWidget(longText),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(find.text(longText), findsOneWidget);
    });

    testWidgets('should handle text overflow in different screen sizes',
        (WidgetTester tester) async {
      const text = 'Test text for different screen sizes';
      final TestWidgetsFlutterBinding binding =
          TestWidgetsFlutterBinding.ensureInitialized();

      // Test in phone size
      await binding.setSurfaceSize(const Size(120, 200));
      await tester.pumpWidget(const MaterialApp(home: AppTextWidget(text)));
      expect(find.text(text), findsOneWidget);

      // Test in Bigger size
      await binding.setSurfaceSize(const Size(800, 400));

      await tester.pumpWidget(const MaterialApp(home: AppTextWidget(text)));
      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should handle multi-line text properly',
        (WidgetTester tester) async {
      const multiLineText = 'Line 1\nLine 2\nLine 3';
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(
            width: 200,
            child: AppTextWidget(multiLineText),
          ),
        ),
      );

      expect(find.text(multiLineText), findsOneWidget);
    });
  });

  // Rendering tests (existing)
  group('rendering', () {
    testWidgets('should render text with correct content',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('should maintain text content after rebuild',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump();
      expect(find.text('Hello World'), findsOneWidget);
    });
  });

  // Widget tree tests (existing)
  group('widget tree', () {
    testWidgets('should be present in widget tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(AppTextWidget), findsOneWidget);
    });

    testWidgets('should contain exactly one Text widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(
          find.descendant(
            of: find.byType(AppTextWidget),
            matching: find.byType(Text),
          ),
          findsOneWidget);
    });

    testWidgets('should contain exactly one Text widget with key',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byKey(const Key('textWidgetKey')), findsOneWidget);
    });

    // compare the text by key of the text widget
    testWidgets('should same for the text by key of the Text widget',
        (WidgetTester tester) async {
      const testText = "Hello World";

      // Build the widget tree
      await tester.pumpWidget(
        const MaterialApp(
          home: AppTextWidget(testText),
        ),
      );

      // Find the Text widget by its key
      final textFinder = find.byKey(const Key('textWidgetKey'));

      // Verify that the Text widget exists
      expect(textFinder, findsOneWidget);

      // Verify that the Text widget contains the correct text
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.data, testText);
    });
  });

  // Accessibility tests
  group('accessibility', () {
    testWidgets('should handle extra-large text scales without overflow',
        (WidgetTester tester) async {
      const textContent = 'Large Scale Text';
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(textScaleFactor: 3.0),
            child: AppTextWidget(textContent),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });

  // Text direction tests
  group('text direction', () {
    testWidgets('should handle LTR text correctly',
        (WidgetTester tester) async {
      const ltrText = 'Hello World';

      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AppTextWidget(ltrText),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(ltrText));
      expect(textWidget.textDirection, null); // Inherits from Directionality
      expect(find.text(ltrText), findsOneWidget);
    });

    testWidgets('should handle RTL text correctly',
        (WidgetTester tester) async {
      const rtlText = 'مرحبا بالعالم';
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: AppTextWidget(rtlText),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(rtlText));
      expect(textWidget.textDirection, null); // Inherits from Directionality
      expect(find.text(rtlText), findsOneWidget);
    });

    testWidgets('should handle mixed LTR and RTL text',
        (WidgetTester tester) async {
      const mixedText = 'Hello مرحبا World عالم';
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AppTextWidget(mixedText),
          ),
        ),
      );

      expect(find.text(mixedText), findsOneWidget);
    });

    testWidgets('should failed if it overrides', (WidgetTester tester) async {
      const ltrText = 'Hello World';
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: AppTextWidget(
              ltrText,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(ltrText));
      expect(textWidget.textDirection, null); // Inherits from Directionality
      expect(find.text(ltrText), findsOneWidget);
    });
  });

  // Performance tests
  group('performance', () {
    testWidgets('should efficiently rebuild with text changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => const AppTextWidget('Initial Text'),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Initial Text'), findsOneWidget);

      // Trigger multiple rebuilds
      for (int i = 0; i < 100; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: StatefulBuilder(
              builder: (context, setState) => AppTextWidget('Text $i'),
            ),
          ),
        );
      }

      // Check if the last rebuild was successful
      expect(find.text('Text 99'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  // Localization tests
  group('localization', () {
    testWidgets('should handle different locale characters',
        (WidgetTester tester) async {
      const textWithDiacritics = 'হ্যালো ফ্লাটার';
      await tester.pumpWidget(
          const MaterialApp(home: AppTextWidget(textWithDiacritics)));
      expect(find.text(textWithDiacritics), findsOneWidget);
    });

    testWidgets('should support different number systems',
        (WidgetTester tester) async {
      const bengaliNumbers = '১২৩৪৫৬৭৮';
      await tester
          .pumpWidget(const MaterialApp(home: AppTextWidget(bengaliNumbers)));
      expect(find.text(bengaliNumbers), findsOneWidget);
    });
  });

  // Input validation tests
  group('input validation', () {
    testWidgets('should handle text with zero-width spaces',
        (WidgetTester tester) async {
      const textWithZeroWidth = 'Hello\u200BWorld';
      await tester.pumpWidget(
          const MaterialApp(home: AppTextWidget(textWithZeroWidth)));
      expect(find.text(textWithZeroWidth), findsOneWidget);
    });

    testWidgets('should handle text with control characters',
        (WidgetTester tester) async {
      const textWithControl = 'Hello\tWorld\nNew Line';
      await tester
          .pumpWidget(const MaterialApp(home: AppTextWidget(textWithControl)));
      expect(find.text(textWithControl), findsOneWidget);
    });
  });
}
