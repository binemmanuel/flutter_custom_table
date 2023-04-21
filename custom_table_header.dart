import 'package:flutter/material.dart';
import 'package:vendor_dashboard/src/widget/widgets.dart';

class CustomTableHeader extends StatelessWidget {
  const CustomTableHeader({
    super.key,
    required this.data,
    this.color,
  });

  final List<CustomTableCell> data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color?.withOpacity(0.35),
      child: Row(
        children: data
            .asMap()
            .map((index, value) => MapEntry(index, value))
            .values
            .toList(),
      ),
    );
  }
}
