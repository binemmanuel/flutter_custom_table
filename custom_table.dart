import 'package:flutter/material.dart';
import 'package:vendor_dashboard/src/widget/widgets.dart';
import 'package:vendor_dashboard/util/utils.dart';

enum CustomTableStyle { solid, underline, none }

class CustomTable extends StatefulWidget {
  const CustomTable({
    super.key,
    required this.headers,
    required this.rows,
    this.width = 1000,
    this.height = 1000,
    this.headerColor,
    this.rowColor,
    this.style = CustomTableStyle.none,
    this.bottomSize = 100,
    this.rowsPerPage = 5,
    this.currentPage = 1,
    this.fullscreen = false,
    this.showNavigators = true,
    this.verticalScrollPhysics,
    this.footerText,
    this.onRowTap,
  });

  /// The table header
  final List<CustomTableCell> headers;

  /// The table data
  final List<List<CustomTableCell>> rows;

  final double width;
  final double height;
  final Color? headerColor;
  final Color? rowColor;
  final CustomTableStyle style;
  final double bottomSize;
  final int rowsPerPage;
  final int currentPage;
  final bool fullscreen;
  final bool showNavigators;
  final ScrollPhysics? verticalScrollPhysics;
  final String? footerText;
  final ValueSetter<int>? onRowTap;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  late ScrollController scrollController;
  late int currentPage;

  List<List<CustomTableCell>> rows = [];
  int totalNumberOfPages = 0;
  late int _oldLength;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    // Get the current page
    currentPage = widget.rows.isNotEmpty ? widget.currentPage : 0;
    _oldLength = widget.rows.length;

    initPagination();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTable oldWidget) {
    if (widget.rows.length != _oldLength) {
      // Get the current page
      currentPage = widget.rows.isNotEmpty ? widget.currentPage : 0;
      _oldLength = widget.rows.length;

      initPagination();
    }

    super.didUpdateWidget(oldWidget);
  }

  void initPagination() {
    if (widget.rows.isEmpty) return;

    // Calculate the total number of pages
    totalNumberOfPages = (widget.rows.length / widget.rowsPerPage).ceil();

    // Render the data on the table with pagination
    renderPage();
  }

  void renderPage() {
    final start = (currentPage - 1) * widget.rowsPerPage;
    int end = currentPage * widget.rowsPerPage;

    if (end > widget.rows.length - 1) {
      end = widget.rows.length;
    }

    rows = widget.rows.getRange(start, end).toList();
  }

  bool get isFirstPage => currentPage <= 1;
  bool get isLastPage => currentPage == totalNumberOfPages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? widget.width - 60
                      : 900,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Table Header
                  CustomTableHeader(
                    data: widget.headers,
                    color: widget.headerColor,
                  ),

                  // Table Content
                  SizedBox(
                    height: widget.fullscreen
                        ? widget.height - widget.bottomSize
                        : null,
                    child: ListView.builder(
                      physics: widget.verticalScrollPhysics,
                      shrinkWrap: true,
                      itemCount: rows.length,
                      itemBuilder: (context, index) {
                        final row = rows[index];

                        return InkWell(
                          onTap: widget.onRowTap == null
                              ? null
                              : () => widget.onRowTap
                                  ?.call(widget.rows.indexOf(row)),
                          child: CustomTableRow(
                            data: row,
                            style: widget.style,
                            color: widget.style == CustomTableStyle.solid
                                ? getStripColor(index)
                                : widget.rowColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Table Footer
        widget.showNavigators
            ? CustomTableFooter(
                leftText: widget.footerText,
                canNext: !isLastPage,
                canPrev: !isFirstPage,
                onNext: nextPage,
                onPrev: prevPage,
                currentPage: currentPage,
                totalPages: totalNumberOfPages,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Color? getStripColor(int index) => index.isOdd ? widget.rowColor : null;

  void nextPage() {
    currentPage += 1;
    renderPage();

    setState(() {});
  }

  void prevPage() {
    currentPage -= 1;
    renderPage();

    setState(() {});
  }
}
