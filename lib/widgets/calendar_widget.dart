import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_plugin/models/year_month_model.dart';
import 'package:intl/intl.dart';
import '../models/calendar_decorator.dart';
import 'week_calendar.dart';
import '../models/cell_design_model.dart';
import 'month_year_view.dart';

/// A widget that has monthly view with all of the calendar including the header
/// with the month name and the icons
/// to toggle between months
/// [onTap] action is triggered on tapping on the specific day
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

  Widget _calendarMonthView() {
    DateTime _weekStartDate = DateTime.now();
    return Column(
      children: List.generate(
        6,
        (index) {
          if (index != 0) {
            _weekStartDate =
                _weekInitialWeekStartDateTime.add(Duration(days: 7 * index));
          } else {
            _weekStartDate = _setInitialWeekDate();
          }
          if (_weekStartDate.lastDayOfWeek.month != _initialDateTime.month &&
              _weekStartDate.firstDayOfWeek.month != _initialDateTime.month) {
            return Container();
          }
          return CalendarWeekRow(
            initalDateTime: _initialDateTime,
            showCurrentDay: true,
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
            weekStartDateTime: _weekStartDate,
          );
        },
      ),
    );
  }

  Widget _calendarHeaderWidget() {
    const double _iconSizes = 24;
    String _monthNameString =
        DateFormat('MMMM').format(_initialDateTime).toString();
    if (_initialDateTime.year != DateTime.now().year) {
      _monthNameString =
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
                size: _iconSizes,
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
                _monthNameString,
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
                size: _iconSizes,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendarWeekDayWidget() {
    List<String> _weekInitials = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      margin: widget.weekDaysMargin ??
          const EdgeInsets.only(
            bottom: 8,
          ),
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _weekInitials.length,
          (index) => Expanded(
            child: Text(
              _weekInitials[index],
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

    _startLimit =
        widget.startLimit ?? /* DateTime.now() */ DateTime(1898, 1, 1);
    _startLimit = _startLimit.copyWith(
      // day: 1,
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
    _endLimit = widget.endLimit ?? DateTime(2100, 12, 31);
    _endLimit = _endLimit.copyWith(
      // day: _endLimit.lastDayOfMonth.day,
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
  }
}
