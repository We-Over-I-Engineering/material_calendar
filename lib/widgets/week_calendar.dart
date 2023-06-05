import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import '../models/cell_design_model.dart';
import 'day_cell.dart';

class CalendarWeekRow extends StatefulWidget {
  final DateTime initalDateTime;
  final DateTime? selectedDate;
  final DateTime weekStartDateTime;
  final Function(DateTime)? onTap;
  final DateTime? startDateLimit;
  final DateTime? endDateLimit;
  final EdgeInsets? cellMargin;
  final EdgeInsets? cellPadding;
  final Function(DateTime)? onDisabledCellTap;
  final bool isEmptyonStart;
  final List<String>? showOnlyFields;
  final bool isDarkMode;
  final bool isExpanded;
  final double cellbetweenPadding;
  final bool showOutOfMonthCells;
  final Color? cellColors;
  final Color? cellContentColor;
  final CalendarCellDecorator? cellDecorator;
  final CalendarCellDecorator? currentDayDecorator;
  final bool showCurrentDay;

  const CalendarWeekRow({
    required this.initalDateTime,
    this.showOutOfMonthCells = true,
    required this.weekStartDateTime,
    this.cellbetweenPadding = 0,
    Key? key,
    this.isExpanded = false,
    this.selectedDate,
    required this.onTap,
    this.startDateLimit,
    this.endDateLimit,
    this.onDisabledCellTap,
    this.isEmptyonStart = false,
    this.showOnlyFields,
    this.isDarkMode = false,
    this.cellMargin,
    this.cellPadding,
    this.cellColors,
    this.cellContentColor,
    this.cellDecorator,
    this.currentDayDecorator,
    this.showCurrentDay = false,
  }) : super(key: key);

  @override
  State<CalendarWeekRow> createState() => _CalendarWeekRowState();
}

class _CalendarWeekRowState extends State<CalendarWeekRow> {
  late DateTime weekStartTime;
  final DateTime currentDateTime = DateTime.now();
  late DateTime _startLimit;
  late DateTime _endLimit;

  void _setInitialWeekDate() {
    weekStartTime = widget.weekStartDateTime.copyWith(
      microsecond: 0,
      millisecond: 0,
      second: 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _initalizeVariables();
  }

  _initalizeVariables() {
    _startLimit = widget.startDateLimit ?? DateTime(1898, 1, 1);
    _startLimit = _startLimit.copyWith(
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
    _endLimit = widget.endDateLimit ?? DateTime(2100, 12, 31);
    _endLimit = _endLimit.copyWith(
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isExpanded ? null : MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          7,
          (index) {
            if (index != 0) {
              weekStartTime = weekStartTime.add(const Duration(days: 1));
            } else {
              _setInitialWeekDate();
            }
            return Opacity(
              opacity: _isInRange(weekStartTime) ? 1 : 0.5,
              child: DayCell(
                dateTime: weekStartTime,
                number: (weekStartTime.day).toString(),
                dayInMonth: _dayIsInMonth(weekStartTime, widget.initalDateTime),
                currentDay: (weekStartTime.month == currentDateTime.month &&
                        weekStartTime.day == currentDateTime.day &&
                        weekStartTime.year == currentDateTime.year) &&
                    widget.showCurrentDay,
                currentDayDec: widget.currentDayDecorator,
                isWeekend:
                    weekStartTime.weekday == 6 || weekStartTime.weekday == 7,
                selectedDay: widget.selectedDate == null
                    ? false
                    : weekStartTime.month == widget.selectedDate!.month &&
                        weekStartTime.day == widget.selectedDate!.day &&
                        weekStartTime.year == widget.selectedDate!.year,
                onTap: (dateTime) {
                  if (widget.onTap != null) {
                    widget.onTap!(dateTime);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isInRange(DateTime weekStartTime) {
    if (weekStartTime.compareTo(_startLimit) == -1) {
      return false;
    }
    if (weekStartTime.compareTo(_endLimit) == 1) {
      return false;
    }
    return true;
  }

  bool _dayIsInMonth(DateTime dateTime, DateTime monthDateTime) {
    bool isIn = false;
    DateTime nextMonth = DateTime(monthDateTime.lastDayOfMonth.year,
        monthDateTime.lastDayOfMonth.month + 1, 1);
    nextMonth = nextMonth.subtract(
      const Duration(
        microseconds: 1,
      ),
    );

    if (dateTime.compareTo(monthDateTime.firstDayOfMonth) == 0 ||
        dateTime.compareTo(monthDateTime.lastDayOfMonth) == 0) {
      return true;
    } else if (dateTime.compareTo(monthDateTime) == 0) {
      return true;
    } else if ((dateTime.compareTo(monthDateTime.firstDayOfMonth) == 1 &&
        dateTime.compareTo(nextMonth) == -1)) {
      return true;
    }
    return isIn;
  }
}
