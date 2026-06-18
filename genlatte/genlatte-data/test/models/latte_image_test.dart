// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte_data/models.dart';
import 'package:test/test.dart';

void main() {
  group('LatteImageBatchParent Serialization', () {
    test('JSON serialization is correct for a LatteImageBatchParent', () {
      final json = {
        'id': 'batch1',
        'imageIndex': 'image1',
      };

      final parent = LatteImageBatchParent.fromJson(json);

      expect(parent.id, 'batch1');
      expect(parent.imageIndex, 'image1');

      final serialized = parent.toJson();
      expect(serialized['id'], 'batch1');
      expect(serialized['imageIndex'], 'image1');
    });
  });

  group('LatteImage Serialization', () {
    test('JSON serialization is correct for a LatteImage', () {
      final json = {
        'imageUrl': 'https://example.com/latte.jpg',
        'prompt': 'A beautiful swan in coffee',
        'description': 'A beautiful swan',
        'questions': [
          {
            'type': 'textQuestion',
            'id': 'q1',
            'question': 'What would you name it?',
            'helpText': 'Enter your answer',
          },
        ],
      };

      final image = LatteImage.fromJson(json);

      expect(image.imageUrl, 'https://example.com/latte.jpg');
      expect(image.prompt, 'A beautiful swan in coffee');
      expect(image.description, 'A beautiful swan');
      expect(image.questions?.length, 1);
      final q = image.questions!.first;
      expect(q, isA<TextQuestion>());
      expect((q as TextQuestion).body, 'What would you name it?');

      final serialized = image.toJson();
      expect(serialized['imageUrl'], 'https://example.com/latte.jpg');
      expect(serialized['prompt'], 'A beautiful swan in coffee');
      expect(
        (serialized['questions'] as List<Map<String, Object?>>).first['type'],
        'textQuestion',
      );
    });
  });

  group('LatteImageBatch Serialization', () {
    test('JSON serialization is correct for a LatteImageBatch', () {
      final json = {
        'id': 'batch001',
        'orderId': 'order001',
        'image0': {
          'imageUrl': 'https://example.com/0.jpg',
          'prompt': 'Prompt 0',
          'description': 'Desc 0',
          'questions': null,
        },
        'image1': {
          'imageUrl': 'https://example.com/1.jpg',
          'prompt': 'Prompt 1',
          'description': 'Desc 1',
          'questions': <Question>[],
        },
        'image2': null,
        'image3': null,
        'parent': {'id': 'batch000', 'imageIndex': 'image2'},
      };

      final batch = LatteImageBatch.fromJson(json);

      expect(batch.id, 'batch001');
      expect(batch.orderId, 'order001');
      expect(batch.image0?.imageUrl, 'https://example.com/0.jpg');
      expect(batch.image1?.prompt, 'Prompt 1');
      expect(batch.image2, isNull);
      expect(batch.parent?.imageIndex, 'image2');

      final serialized = batch.toJson();
      expect(serialized['id'], 'batch001');
      expect(serialized['orderId'], 'order001');
      expect(
        (serialized['image0'] as Map)['imageUrl'],
        'https://example.com/0.jpg',
      );
      expect(serialized['image2'], isNull);
      expect((serialized['parent'] as Map)['imageIndex'], 'image2');
    });
  });

  group('LatteImage answerQuestion', () {
    const defaultQuestion = Question.multipleChoice(
      id: 'q1',
      body: 'Size?',
      acceptableAnswers: ['Small', 'Large'],
    );
    const textQuestion = Question(
      id: 'q2',
      body: 'Name?',
    );
    const img = LatteImage(
      imageUrl: 'url',
      prompt: 'prompt',
      description: 'desc',
      questions: [defaultQuestion, textQuestion],
    );

    test('updates the correct question with the given answer', () {
      final updatedImg = img.answerQuestion(defaultQuestion, 'Large');

      expect(
        (updatedImg.questions![0] as MultipleChoiceQuestion).selectedValue,
        'Large',
      );
      expect((updatedImg.questions![1] as TextQuestion).answer, isNull);
    });

    test('throws if questions list is null or empty', () {
      const emptyImg = LatteImage(
        imageUrl: 'url',
        prompt: 'prompt',
        description: 'desc',
        questions: null,
      );

      expect(
        () => emptyImg.answerQuestion(defaultQuestion, 'answer'),
        throwsA(isA<AssertionError>()),
      );
    });

    test('throws if question is not found in the list', () {
      const notFoundQuestion = Question(id: 'q3', body: 'Missing?');
      expect(
        () => img.answerQuestion(notFoundQuestion, 'answer'),
        throwsException,
      );
    });
  });

  group('LatteImageBatch answerQuestion', () {
    const q = Question(id: 'q1', body: 'Test?');
    const imgTemplate = LatteImage(
      imageUrl: 'url',
      prompt: 'prompt',
      description: 'desc',
      questions: [q],
    );
    const batch = LatteImageBatch(
      id: 'batch1',
      orderId: 'order1',
      image0: imgTemplate,
      image1: imgTemplate,
      image2: imgTemplate,
      image3: imgTemplate,
    );

    test('updates image0 if index is 0', () {
      final updatedBatch = batch.answerQuestion(0, q, 'ans0');
      expect(
        (updatedBatch.image0!.questions!.first as TextQuestion).answer,
        'ans0',
      );
      expect(
        (updatedBatch.image1!.questions!.first as TextQuestion).answer,
        isNull,
      );
    });

    test('updates image1 if index is 1', () {
      final updatedBatch = batch.answerQuestion(1, q, 'ans1');
      expect(
        (updatedBatch.image1!.questions!.first as TextQuestion).answer,
        'ans1',
      );
      expect(
        (updatedBatch.image0!.questions!.first as TextQuestion).answer,
        isNull,
      );
    });

    test('updates image2 if index is 2', () {
      final updatedBatch = batch.answerQuestion(2, q, 'ans2');
      expect(
        (updatedBatch.image2!.questions!.first as TextQuestion).answer,
        'ans2',
      );
      expect(
        (updatedBatch.image3!.questions!.first as TextQuestion).answer,
        isNull,
      );
    });

    test('updates image3 if index is 3', () {
      final updatedBatch = batch.answerQuestion(3, q, 'ans3');
      expect(
        (updatedBatch.image3!.questions!.first as TextQuestion).answer,
        'ans3',
      );
      expect(
        (updatedBatch.image2!.questions!.first as TextQuestion).answer,
        isNull,
      );
    });

    test('throws RangeError for invalid index', () {
      expect(
        () => batch.answerQuestion(4, q, 'ans'),
        throwsRangeError,
      );
    });
  });
}
