// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte_data/models.dart';

/// A card widget for displaying a [Machine].
class MachineCard extends StatefulWidget {
  /// Creates a new [MachineCard].
  const MachineCard({
    required this.machine,
    required this.toggleStatus,
    required this.onDelete,
    super.key,
  });

  /// The [Machine] to display.
  final Machine machine;

  /// Callback for when the toggle status button is pressed.
  final void Function() toggleStatus;

  /// Callback for when the delete button is pressed.
  final void Function() onDelete;

  @override
  State<MachineCard> createState() => _MachineCardState();
}

class _MachineCardState extends State<MachineCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.machine.isActive;
    final isColor = !widget.machine.isBlackAndWhite;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, _isHovered ? -2.0 : 0.0, 0),
        width: 320,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.05),
              blurRadius: _isHovered ? 16 : 12,
              offset: Offset(0, _isHovered ? 6 : 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Name and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.machine.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                _buildStatusBadge(isActive),
              ],
            ),
            const SizedBox(height: 16),

            // Capabilities / Specs
            _buildSpecBadge(isColor),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    label: isActive ? 'Deactivate' : 'Activate',
                    textColor: isActive
                        ? const Color.fromARGB(255, 223, 93, 93)
                        : const Color(0xFF2563EB),
                    backgroundColor: isActive
                        ? AppColors.white
                        : const Color(0xFFEFF6FF),
                    borderColor: isActive
                        ? const Color.fromARGB(255, 255, 202, 202)
                        : const Color(0xFFBFDBFE),
                    onPressed: widget.toggleStatus,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildActionButton(
                    label: 'Delete',
                    textColor: const Color(0xFFDC2626),
                    backgroundColor: const Color(0xFFFEF2F2),
                    borderColor: const Color(0xFFFECACA),
                    onPressed: widget.onDelete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for Internal Components ---

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF22C55E)
                  : const Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isActive ? 'ACTIVE' : 'OFFLINE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: isActive
                  ? const Color(0xFF15803D)
                  : const Color(0xFFB91C1C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecBadge(bool isColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isColor ? '🎨 Color' : '⚫ B&W Only',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color textColor,
    required Color backgroundColor,
    required Color borderColor,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
