// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';

/// A reusable widget that allows users to select a [Machine] from a list.
class MachineSelection extends StatefulWidget {
  /// Creates a new [MachineSelection] widget.
  const MachineSelection({
    required this.machines,
    required this.onSubmitted,
    this.initialSelection,
    super.key,
  });

  /// The list of available machines to choose from.
  final List<Machine> machines;

  /// The machine that should be selected by default.
  final Machine? initialSelection;

  /// Callback fired when the user selects a machine and clicks "Submit".
  final void Function(Machine) onSubmitted;

  @override
  State<MachineSelection> createState() => _MachineSelectionState();
}

class _MachineSelectionState extends State<MachineSelection> {
  Machine? _selectedMachine;

  @override
  void initState() {
    super.initState();
    _selectedMachine = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.machines.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final machine = widget.machines[index];
              final isSelected = _selectedMachine?.id == machine.id;

              return _MachineSelectionTile(
                machine: machine,
                isSelected: isSelected,
                onTap: () => setState(() => _selectedMachine = machine),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        if (_selectedMachine != null)
          Flexible(
            child: GenLatteOutlinedButton.dark(
              label: 'Submit Selection',
              onPressed: () => widget.onSubmitted(_selectedMachine!),
            ),
          ),
      ],
    );
  }
}

class _MachineSelectionTile extends StatefulWidget {
  const _MachineSelectionTile({
    required this.machine,
    required this.isSelected,
    required this.onTap,
  });

  final Machine machine;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_MachineSelectionTile> createState() => _MachineSelectionTileState();
}

class _MachineSelectionTileState extends State<_MachineSelectionTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF18181B) // Zinc 900
                : (_isHovered
                      ? const Color(0xFFF4F4F5)
                      : Colors.white), // Zinc 100
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF18181B)
                  : const Color(0xFFE4E4E7), // Zinc 200
              width: 2,
            ),
            boxShadow: [
              if (isSelected || _isHovered)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF27272A) // Zinc 800
                      : const Color(0xFFF4F4F5), // Zinc 100
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.coffee_maker_outlined,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF71717A), // Zinc 500
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.machine.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF18181B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.machine.isBlackAndWhite
                          ? 'Black & White 🔲'
                          : 'Full Color 🎨',
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.7)
                            : const Color(0xFF71717A),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
