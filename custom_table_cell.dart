import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    super.key,
    required this.value,
    this.flex = 1,
    this.valueStyle,
    this.onTap,
  });

  final Widget value;
  final int flex;
  final TextStyle? valueStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: value,
        ),
      ),
    );
  }
}
