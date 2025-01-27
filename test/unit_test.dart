import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_tesing/main.dart';

/**
 * Created by Abdullah on 27/1/25.
 */

void main() {
  group('AppTextWidget Unit Tests', () {
    group('Constructor', () {
      test('should create instance with valid text', () {
        const widget = AppTextWidget('Test');
        expect(widget.text, 'Test');
      });

    });

    group('isValidText', () {
      test('should return true for non-empty text', () {
        const widget = AppTextWidget('Hello');
        expect(widget.isValidText(), true);
      });

      test('should return false for empty text', () {
        const widget = AppTextWidget('');
        expect(widget.isValidText(), false);
      });

      test('should return false for whitespace-only text', () {
        const widget = AppTextWidget('   ');
        expect(widget.isValidText(), true);
      });
    });

    group('getTextLength', () {
      test('should return correct length for normal text', () {
        const widget = AppTextWidget('Hello');
        expect(widget.getTextLength(), 5);
      });

      test('should return 0 for empty text', () {
        const widget = AppTextWidget('');
        expect(widget.getTextLength(), 0);
      });

      test('should count spaces in text length', () {
        const widget = AppTextWidget('Hello World');
        expect(widget.getTextLength(), 11);
      });
    });

    group('containsNumbers', () {
      test('should return true when text contains numbers', () {
        const widget = AppTextWidget('Hello123');
        expect(widget.containsNumbers(), true);
      });

      test('should return false when text contains no numbers', () {
        const widget = AppTextWidget('Hello');
        expect(widget.containsNumbers(), false);
      });

      test('should return false for empty text', () {
        const widget = AppTextWidget('');
        expect(widget.containsNumbers(), false);
      });
    });

    group('containsSpecialCharacters', () {
      test('should return true when text contains special characters', () {
        const widget = AppTextWidget('Hello!@#');
        expect(widget.containsSpecialCharacters(), true);
      });

      test('should return false when text contains no special characters', () {
        const widget = AppTextWidget('Hello123');
        expect(widget.containsSpecialCharacters(), false);
      });

      test('should return false for empty text', () {
        const widget = AppTextWidget('');
        expect(widget.containsSpecialCharacters(), false);
      });
    });

    group('getWordCount', () {
      test('should return correct word count for normal text', () {
        const widget = AppTextWidget('Hello World Test');
        expect(widget.getWordCount(), 3);
      });

      test('should return 0 for empty text', () {
        const widget = AppTextWidget('');
        expect(widget.getWordCount(), 0);
      });

      test('should handle multiple spaces correctly', () {
        const widget = AppTextWidget('Hello    World   Test');
        expect(widget.getWordCount(), 3);
      });

      test('should handle leading/trailing spaces', () {
        const widget = AppTextWidget('  Hello World  ');
        expect(widget.getWordCount(), 2);
      });
    });

    group('getTruncatedText', () {
      test('should not truncate text shorter than maxLength', () {
        const widget = AppTextWidget('Hello');
        expect(widget.getTruncatedText(maxLength: 10), 'Hello');
      });

      test('should truncate text longer than maxLength', () {
        const widget = AppTextWidget('This is a very long text that needs truncation');
        expect(widget.getTruncatedText(maxLength: 10), 'This is a ...');
      });

      test('should handle empty text', () {
        const widget = AppTextWidget('');
        expect(widget.getTruncatedText(maxLength: 10), '');
      });
    });

    group('getCapitalizedText', () {
      test('should capitalize first letter of each word', () {
        const widget = AppTextWidget('hello world test');
        expect(widget.getCapitalizedText(), 'Hello World Test');
      });

      test('should handle already capitalized text', () {
        const widget = AppTextWidget('Hello World');
        expect(widget.getCapitalizedText(), 'Hello World');
      });

      test('should handle empty text', () {
        const widget = AppTextWidget('');
        expect(widget.getCapitalizedText(), '');
      });

      test('should handle mixed case text', () {
        const widget = AppTextWidget('hELLo WoRLD');
        expect(widget.getCapitalizedText(), 'Hello World');
      });
    });

    group('getNormalizedText', () {
      test('should remove extra whitespace', () {
        const widget = AppTextWidget('Hello   World    Test');
        expect(widget.getNormalizedText(), 'Hello World Test');
      });

      test('should trim leading and trailing whitespace', () {
        const widget = AppTextWidget('  Hello World  ');
        expect(widget.getNormalizedText(), 'Hello World');
      });

      test('should handle empty text', () {
        const widget = AppTextWidget('');
        expect(widget.getNormalizedText(), '');
      });

      test('should handle text with only whitespace', () {
        const widget = AppTextWidget('   ');
        expect(widget.getNormalizedText(), '');
      });
    });
  });
}