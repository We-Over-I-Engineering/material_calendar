import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:material_calendar/models/year_month_model.dart';
import 'package:intl/intl.dart';
import '../models/calendar_decorator.dart';
import 'week_calendar.dart';
import '../models/cell_design_model.dart';
import 'month_year_view.dart';

/// A widget that has monthly view with all of the calendar including the header
/// with the month name and the icons
/// to toggle between months
/// `onTap` action is triggered on tapping on the specific day.
///
///

///`monthYearOverlayValueDecorator` is the decorator of the month and year view on tap of the header month text.
///You can update the color for circular container, text and and norder.
///
///Use `calendarDecorator` for declearing background color for the widget

class CalendarWidget extends StatefulWidget {
  final DateTime initalDateTime;
  final DateTime? selectedDate;
  final EdgeInsets? headerMargins;
  final EdgeInsets? weekDaysMargin;
  final EdgeInsets? calendarContainerMargin;
  final DateTime? startLimit;
  final DateTime? endLimit;
  final Function(DateTime)? onTap;
  final CircularDecorator? monthYearOverlayValueDecorator;
  final CalendarDecorator? calendarDecorator;
  final bool showCurrentDay;

  const CalendarWidget({
    Key? key,
    required this.initalDateTime,
    this.headerMargins,
    this.selectedDate,
    this.weekDaysMargin,
    this.calendarContainerMargin,
    this.startLimit,
    this.endLimit,
    this.onTap,
    this.monthYearOverlayValueDecorator,
    this.calendarDecorator,
    this.showCurrentDay = true,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _initialDateTime;
  late DateTime _weekInitialWeekStartDateTime;
  late DateTime? _selectedDate;
  Function(DateTime)? _onTap;

  late DateTime _startLimit;

  late DateTime _endLimit;

  @override
  void initState() {
    super.initState();
    _initializeCalendar(widget.initalDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.calendarDecorator?.backgroundColor ?? Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _calendarHeaderWidget(),
          _calendarWeekDayWidget(),
          _calendarMonthView(),
        ],
      ),
    );
  }

  /// The only month section with the [Daycell] widgets representing the date
  Widget _calendarMonthView() {
    DateTime weekStartDate = DateTime.now();
    return Column(
      children: List.generate(
        6,
        (index) {
          if (index != 0) {
            weekStartDate =
                _weekInitialWeekStartDateTime.add(Duration(days: 7 * index));
          } else {
            weekStartDate = _setInitialWeekDate();
          }
          if (weekStartDate.lastDayOfWeek.month != _initialDateTime.month &&
              weekStartDate.firstDayOfWeek.month != _initialDateTime.month) {
            return Container();
          }
          return CalendarWeekRow(
            initalDateTime: _initialDateTime,
            showCurrentDay: widget.showCurrentDay,
            showOutOfMonthCells: false,
            currentDayDecorator: CalendarCellDecorator(
              color: Colors.black,
              contentColor: Colors.white,
            ),
            startDateLimit: _startLimit,
            endDateLimit: _endLimit,
            cellDecorator: CalendarCellDecorator(
              color: Colors.white,
              contentColor: Colors.black,
            ),
            selectedDate: _selectedDate,
            onTap: (dateTime) {
              _selectedDate = dateTime;
              if (_onTap != null) {
                _onTap!(dateTime);
              }
              setState(() {});
            },
            weekStartDateTime: weekStartDate,
          );
        },
      ),
    );
  }

  /// The header of the calendar that will have the icons for navigating between months and text with showing month name
  Widget _calendarHeaderWidget() {
    const double iconSizes = 24;
    String monthNameString =
        DateFormat('MMMM').format(_initialDateTime).toString();
    if (_initialDateTime.year != DateTime.now().year) {
      monthNameString =
          DateFormat('MMMM yyyy').format(_initialDateTime).toString();
    }

    return Container(
      margin: widget.headerMargins ??
          const EdgeInsets.only(
            top: 4,
          ),
      height: 56,
      child: Padding(
        padding: widget.calendarContainerMargin ??
            const EdgeInsets.only(
              left: 32,
              right: 32,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _movePreviousMonth();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: iconSizes,
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (innerContext) {
                    return MonthYearViewSheet(
                      dateTime: _initialDateTime,
                      startLimit: _startLimit,
                      circularDecorator: widget.monthYearOverlayValueDecorator,
                      endLimit: _endLimit,
                      onTap: (DateTime dateTime) {
                        _initializeCalendar(dateTime);
                        setState(() {});
                      },
                    );
                  },
                );
              },
              child: Text(
                monthNameString,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _moveToNextMonth();
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                size: iconSizes,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The row with the week days initials that will help in understand the day of the week
  Widget _calendarWeekDayWidget() {
    List<String> weekInitials = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      margin: widget.weekDaysMargin ??
          const EdgeInsets.only(
            bottom: 8,
          ),
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          weekInitials.length,
          (index) => Expanded(
            child: Text(
              weekInitials[index],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  DateTime _setInitialWeekDate() {
    return _weekInitialWeekStartDateTime;
  }

  _movePreviousMonth() {
    DateTime previousMonth =
        DateTime(_initialDateTime.year, _initialDateTime.month - 1)
            .lastDayOfMonth;
    if (previousMonth.compareTo(_startLimit) == -1) {
      return;
    }

    _weekInitialWeekStartDateTime =
        DateTime(_initialDateTime.year, _initialDateTime.month - 1)
            .firstDayOfMonth
            .firstDayOfWeek;
    _initialDateTime =
        DateTime(_initialDateTime.year, _initialDateTime.month - 1);
    setState(() {});
  }

  _moveToNextMonth() {
    DateTime previousMonth =
        DateTime(_initialDateTime.year, _initialDateTime.month + 1)
            .firstDayOfMonth;

    if (previousMonth.compareTo(_endLimit) == 1) {
      return;
    }

    _weekInitialWeekStartDateTime =
        DateTime(_initialDateTime.year, _initialDateTime.month + 1)
            .firstDayOfMonth
            .firstDayOfWeek;
    _initialDateTime =
        DateTime(_initialDateTime.year, _initialDateTime.month + 1);
    setState(() {});
  }

  void _initializeCalendar(DateTime initalDateTime) {
    _initialDateTime = initalDateTime;
    _weekInitialWeekStartDateTime =
        initalDateTime.firstDayOfMonth.firstDayOfWeek;
    _selectedDate = widget.selectedDate;
    _onTap = widget.onTap;

    _startLimit = widget.startLimit ?? DateTime(1898, 1, 1);
    _startLimit = _startLimit.copyWith(
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
    _endLimit = widget.endLimit ?? DateTime(2100, 12, 31);
    _endLimit = _endLimit.copyWith(
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
  }
}
