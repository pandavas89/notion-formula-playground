import 'package:flutter/material.dart';
import 'dart:math';

class FormulaHeader extends StatelessWidget {
  final String name;

  const FormulaHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)));
  }
}

class FormulaItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final VoidCallback? onInsert;

  const FormulaItem(
      {super.key, required this.name, required this.icon, this.onInsert});

  @override
  State<FormulaItem> createState() => _FormulaItemState();
}

class _FormulaItemState extends State<FormulaItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onInsert,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered ? Colors.grey[200] : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Text(widget.name, style: const TextStyle(fontSize: 16)),
              ),
              Opacity(
                opacity: isHovered ? 1.0 : 0.0,
                child: Transform.rotate(
                    angle: pi / 2,
                    child: const Icon(Icons.u_turn_right, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
