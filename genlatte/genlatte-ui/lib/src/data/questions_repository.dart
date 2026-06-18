// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:data_layer/data_layer.dart';
// import 'package:genlatte/src/data/data.dart';
// import 'package:genlatte_data/models.dart';

// /// Repository for managing [Question]s.
// class QuestionsRepository extends Repository<Question> {
//   /// Instantiates a [QuestionsRepository].
//   QuestionsRepository()
//     : super(
//         SourceList<Question>(
//           sources: [
//             LocalMemorySource<Question>(
//               bindings: Question.bindings,
//             ),
//           ],
//           bindings: Question.bindings,
//         ),
//       ) {
//     setItems(
//       const [
//         Question.slider(
//           id: 'abc',
//           body: 'How hot should this be?',
//           minValueLabel: 'Cold',
//           maxValueLabel: 'Hot',
//         ),
//         Question.multipleChoice(
//           id: 'xyz',
//           body: 'What time of day is it?',
//           options: [
//             'Morning',
//             'Afternoon',
//             'Evening',
//             'Night',
//           ],
//         ),
//         Question.text(
//           id: '123',
//           body: 'How much do you like pizza?',
//           helpText: 'A lot, not so much, or somewhere in between?',
//         ),
//         Question.valueShiftSlider(
//           id: '234',
//           body: 'More, fewer, or the same amount of trees?',
//           minValueLabel: 'Fewer',
//           maxValueLabel: 'More',
//         ),
//       ],
//       RequestDetails.read(
//         filter: const QuestionForLatteImage(latteImageId: '1'),
//       ),
//     ).ignore();
//   }
// }
