import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomTableFooter extends StatelessWidget {
  const CustomTableFooter({
    super.key,
    this.leftText,
    this.currentPage = 0,
    this.totalPages = 0,
    this.canNext = false,
    this.canPrev = false,
    this.onNext,
    this.onPrev,
  });

  /// Displayed a custom text on the right
  final String? leftText;

  /// Displayed the current pages
  final int currentPage;

  /// Displayed the total number of pages
  final int totalPages;

  /// Decide if a user can press the previous button
  final bool canNext;

  /// Decide if a user can press the next button
  final bool canPrev;

  /// When [onNext] is provided the next button is activated
  /// for users to click to the next page
  final VoidCallback? onNext;

  /// When [onPrev] is provided the prev button is activated
  /// for users to click to the preview page
  final VoidCallback? onPrev;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          leftText ?? '',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey),
        ),
        //

        const Spacer(),

        Text(
          '$currentPage/$totalPages pages',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey),
        ),

        const SizedBox(width: 20),

        OutlinedButton(
          onPressed: canPrev ? onPrev : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //
              Icon(Ionicons.caret_back_outline, size: 10),

              SizedBox(width: 10),

              Text('Prev'),
            ],
          ),
        ),

        const SizedBox(width: 10),

        OutlinedButton(
          onPressed: canNext ? onNext : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //
              Text('Next'),

              SizedBox(width: 10),

              Icon(Ionicons.caret_forward_outline, size: 10),
            ],
          ),
        ),
      ],
    );
  }
}
