import 'package:flutter/material.dart';
import 'package:vendor_dashboard/src/widget/table/exceptions/custom_table_exception.dart';
import 'package:vendor_dashboard/src/widget/widgets.dart';

class CustomTableRow extends StatelessWidget {
  CustomTableRow({
    super.key,
    this.color,
    required this.data,
    required this.style,
  }) {
    if (style == CustomTableStyle.underline && color == null) {
      throw CustomTableException(
        'A color is required to paint [$style] style',
      );
    }
  }

  final List<CustomTableCell> data;
  final Color? color;
  final CustomTableStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            style == CustomTableStyle.solid ? color?.withOpacity(0.25) : null,

        //
        border: style == CustomTableStyle.underline
            ? Border(bottom: BorderSide(color: color!))
            : null,
      ),
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
