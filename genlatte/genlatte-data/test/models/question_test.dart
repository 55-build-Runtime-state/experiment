// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte_data/models.dart';
import 'package:test/test.dart';

void main() {
  group('Question Serialization', () {
    test('JSON serialization is correct for a TextQuestion', () {
      final json = {
        'type': 'textQuestion',
        'id': 'q_name',
        'question': 'What is your name?',
        'helpText': 'Please enter your first name',
        'answer': 'Alice',
      };

      final question = Question.fromJson(json) as TextQuestion;

      expect(question.id, 'q_name');
      expect(question.body, 'What is your name?');
      expect(question.helpText, 'Please enter your first name');
      expect(question.answer, 'Alice');

      final serialized = question.toJson();
      expect(serialized['type'], 'textQuestion');
      expect(serialized['id'], 'q_name');
      expect(serialized['question'], 'What is your name?');
      expect(serialized['helpText'], 'Please enter your first name');
      expect(serialized['answer'], 'Alice');
    });

    test('JSON serialization is correct for a MultipleChoiceQuestion', () {
      final json = {
        'type': 'multipleChoiceQuestion',
        'id': 'q_milk',
        'question': 'What milk do you want?',
        'acceptableAnswers': ['Oat', 'Almond', 'Whole'],
        'selectedValue': 'Oat',
      };

      final question = Question.fromJson(json) as MultipleChoiceQuestion;

      expect(question.id, 'q_milk');
      expect(question.body, 'What milk do you want?');
      expect(question.acceptableAnswers, ['Oat', 'Almond', 'Whole']);
      expect(question.selectedValue, 'Oat');

      final serialized = question.toJson();
      expect(serialized['type'], 'multipleChoiceQuestion');
      expect(serialized['question'], 'What milk do you want?');
      expect(serialized['acceptableAnswers'], ['Oat', 'Almond', 'Whole']);
      expect(serialized['selectedValue'], 'Oat');
    });

    test('JSON serialization is correct for a ZeroToOneQuestion', () {
      final json = {
        'type': 'zeroToOneQuestion',
        'id': 'q_roast',
        'question': 'How dark do you want your roast?',
        'minValueLabel': 'Light',
        'maxValueLabel': 'Dark',
        'selectedValue': 0.75,
      };

      final question = Question.fromJson(json) as ZeroToOneQuestion;

      expect(question.id, 'q_roast');
      expect(question.body, 'How dark do you want your roast?');
      expect(question.minValueLabel, 'Light');
      expect(question.maxValueLabel, 'Dark');
      expect(question.selectedValue, 0.75);

      final serialized = question.toJson();
      expect(serialized['type'], 'zeroToOneQuestion');
      expect(serialized['question'], 'How dark do you want your roast?');
      expect(serialized['selectedValue'], 0.75);
    });

    test('JSON serialization is correct for a NegativeOneToOneQuestion', () {
      final json = {
        'type': 'negativeOneToOneQuestion',
        'id': 'q_brightness',
        'question': 'Adjust brightness',
        'minValueLabel': 'Darker',
        'maxValueLabel': 'Brighter',
        'selectedValue': -0.5,
      };

      final question = Question.fromJson(json) as NegativeOneToOneQuestion;

      expect(question.id, 'q_brightness');
      expect(question.body, 'Adjust brightness');
      expect(question.minValueLabel, 'Darker');
      expect(question.maxValueLabel, 'Brighter');
      expect(question.selectedValue, -0.5);

      final serialized = question.toJson();
      expect(serialized['type'], 'negativeOneToOneQuestion');
      expect(serialized['question'], 'Adjust brightness');
      expect(serialized['selectedValue'], -0.5);
    });
  });
}
