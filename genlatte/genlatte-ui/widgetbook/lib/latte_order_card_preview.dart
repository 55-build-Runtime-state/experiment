// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:genlatte/src/role.dart';
import 'package:genlatte/src/screens/barista/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';

@widgetbook.UseCase(name: 'Latte Order Card', type: LatteOrderCard)
Widget buildLatteOrderCardUseCase(BuildContext context) {
  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 230,
    min: 150,
    max: 400,
  );

  final height = context.knobs.double.slider(
    label: 'Height',
    initialValue: 420,
    min: 300,
    max: 600,
  );

  final role = context.knobs.object.dropdown<Role>(
    label: 'Role',
    options: [Role.barista, Role.moderator],
    initialOption: Role.barista,
  );

  final status = context.knobs.object.dropdown<LatteOrderStatus>(
    label: 'Status',
    options: LatteOrderStatus.values,
    initialOption: LatteOrderStatus.inProgress,
  );

  final canClaimOrders = context.knobs.boolean(
    label: 'Can Claim Orders',
    initialValue: true,
  );

  final isClaimed = context.knobs.boolean(
    label: 'Is Claimed',
    initialValue: true,
  );

  final isClaimedByMe = context.knobs.boolean(
    label: 'Is Claimed By Me',
    initialValue: true,
  );

  final myBarista = const Barista(
    id: 'barista-me',
    username: 'craig',
    persona: BaristaPersona.caucasianMale,
  );

  final otherBarista = const Barista(
    id: 'barista-other',
    username: 'other',
    persona: BaristaPersona.asianFemale,
  );

  final activeBarista = role == Role.barista ? myBarista : null;

  final claimedBy = isClaimed
      ? (isClaimedByMe ? myBarista : otherBarista)
      : null;

  final latte = Latte(
    order: const LatteOrder(
      id: 'order-123',
      name: 'BigDumbIdiot',
      milk: 'Whole Milk',
      sweetener: 'Sugar',
      happyPlace: 'A quiet beach at sunset',
    ),
    metadata: LatteOrderMetadata(
      id: 'order-123',
      orderNumber: 42,
      isNameApproved: true,
      isHappyPlaceApproved: true,
      isImageApproved: true,
      imageUrl:
          'https://storage.googleapis.com/gcdemos-26-int-dd-latteart.firebasestorage.app/latteImages%2F0E4db620KWrbK3K5k13t%2F0.png',
      status: status,
      baristaId: claimedBy?.id,
      orderSubmittedTime: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  );

  return Center(
    child: SizedBox(
      height: height,
      width: width,
      child: role == Role.barista
          ? LatteOrderCard.barista(
              activeBarista: activeBarista,
              canClaimOrders: canClaimOrders,
              claimedBy: claimedBy,
              latte: latte,
              onApproveAll: (_) {},
              onRejectName: (_) {},
              onRejectImage: (_) {},
              onRejectBoth: (_) {},
              onClaimPressed: (_) {},
              onCompletePressed: (_) {},
              onReprintPressed: (_) {},
              role: role,
            )
          : LatteOrderCard.moderator(
              claimedBy: claimedBy,
              latte: latte,
              onApproveAll: (_) {},
              onRejectName: (_) {},
              onRejectImage: (_) {},
              onRejectBoth: (_) {},
              onCompletePressed: (_) {},
            ),
    ),
  );
}
