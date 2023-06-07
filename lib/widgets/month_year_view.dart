import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../models/year_month_model.dart';

/// This widget shows the month and year view overlay
///
/// `onTap` will result the selected month
///
/// You can choose the `startLimit` and `endLimit` of that overlay to show
///
/// The initial month and year of the overlay will depend on the `dateTime` value
class MonthYearViewSheet extends StatefulWidget {
  final DateTime dateTime;
  final Function(DateTime) onTap;
  final DateTime? startLimit;
  final DateTime? endLimit;
  final CircularDecorator? circularDecorator;
  const MonthYearViewSheet({
    Key? key,
    required this.dateTime,
    required this.onTap,
    this.startLimit,
    this.endLimit,
    this.circularDecorator,
  }) : super(key: key);

  @override
  State<MonthYearViewSheet> createState() => _MonthYearViewSheetState();
}

class _MonthYearViewSheetState extends State<MonthYearViewSheet> {
  List<List<int>> _yearList = [];
  late int _yearSelected;
  late int _monthSelected;
  late DateTime _startLimit;
  late DateTime _endLimit;

  int _currentIndex = 0;

  final List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  bool _showMonthView = true;

  @override
  void initState() {
    super.initState();
    _initializeLimits();
    _initializeYearlyMonthlyLimits();
    _initializeBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _headerRow(),
          _monthYearView(),
        ],
      ),
    );
  }

  Widget _headerRow() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (_showMonthView) {
                if (_yearSelected > _startLimit.year) {
                  _yearSelected = _yearSelected - 1;
                  _updateYearRangeIfNeeded();
                }
              } else {
                if (_currentIndex >= 1) {
                  _currentIndex--;
                }
              }
              setState(() {});
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
            ),
          ),
          InkWell(
            onTap: () {
              _showMonthView = !_showMonthView;
              setState(() {});
            },
            child: Text(
              _showMonthView
                  ? "$_yearSelected"
                  : "${_yearList[_currentIndex][0]} - ${_yearList[_currentIndex][1]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (_showMonthView) {
                if (_yearSelected < _endLimit.year) {
                  _yearSelected = _yearSelected + 1;
                  _updateYearRangeIfNeeded();
                }
              } else {
                if (_currentIndex < _yearList.length - 1) {
                  _currentIndex++;
                }
              }
              setState(() {});
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthYearView() {
    return GridView.count(
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      shrinkWrap: true,
      crossAxisCount: 4,
      children: _showMonthView
          ? List.generate(
              _monthNames.length,
              (index) => _circularContainer(
                _monthNames[index],
                () {
                  _monthSelected = index + 1;
                  widget.onTap(DateTime(
                    _yearSelected,
                    _monthSelected,
                    widget.dateTime.day,
                  ));
                  Navigator.pop(context);
                },
                isSelected: index + 1 == _monthSelected &&
                    _yearSelected == widget.dateTime.year,
                isDisabled: _monthIsDisabled(index + 1),
              ),
            )
          : List.generate(
              12,
              (index) => _circularContainer(
                (_yearList[_currentIndex][0] + index).toString(),
                () {
                  _yearSelected = _yearList[_currentIndex][0] + index;
                  setState(() {
                    _showMonthView = !_showMonthView;
                  });
                },
                isSelected:
                    _yearList[_currentIndex][0] + index == widget.dateTime.year,
                isDisabled:
                    _yearIsDisabled(_yearList[_currentIndex][0] + index),
              ),
            ),
    );
  }

  bool _yearIsDisabled(int year) {
    if (year < _startLimit.year) {
      return true;
    }
    if (year > _endLimit.year) {
      return true;
    }
    return false;
  }

  bool _monthIsDisabled(int month) {
    if (DateTime(_yearSelected, month, 1, 0, 0, 0, 0, 0)
            .compareTo(_startLimit) ==
        -1) {
      return true;
    }
    if (DateTime(_yearSelected, month, 1, 0, 0, 0, 0, 0).compareTo(_endLimit) ==
        1) {
      return true;
    }
    return false;
  }

  Widget _circularContainer(
    String text,
    Function onTap, {
    bool isSelected = false,
    bool isDisabled = false,
  }) {
    return Opacity(
      opacity: isDisabled ? 0.4 : 1,
      child: InkWell(
        onTap: () {
          if (isDisabled) {
            return;
          }
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? widget.circularDecorator?.selectedColor ?? Colors.black
                : widget.circularDecorator?.color ?? Colors.grey.shade200,
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.circularDecorator?.borderColor ?? Colors.black,
              width: 2,
            ),
          ),
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10,
          ),
          child: Center(
            child: Text(
              text,
              style: widget.circularDecorator?.textStyle ??
                  TextStyle(
                    fontSize: 15,
                    color: isSelected
                        ? widget.circularDecorator?.selectedTextColor ??
                            Colors.white
                        : widget.circularDecorator?.textColor ?? Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _initializeBottomSheet() {
    _yearSelected = widget.dateTime.year;
    _monthSelected = widget.dateTime.month;
    for (var i = 0; i < _yearList.length; i++) {
      if (widget.dateTime.year > _yearList[i][0] - 1 &&
          widget.dateTime.year < _yearList[i][1] + 1) {
        _currentIndex = i;
        break;
      }
    }
  }

  void _updateYearRangeIfNeeded() {
    for (var i = 0; i < _yearList.length; i++) {
      if (_yearSelected > _yearList[i][0] - 1 &&
          _yearSelected < _yearList[i][1] + 1) {
        _currentIndex = i;
        break;
      }
    }
  }

  _initializeYearlyMonthlyLimits() {
    _yearList = List.generate(18, (index) {
      int firstValue = 1893 + (index * 12);
      int lastValue = 1893 + ((index + 1) * 12 - 1);
      if (_startLimit.year > lastValue) {
        return [];
      }
      if (_endLimit.year < firstValue) {
        return [];
      }

      return [firstValue, lastValue];
    });
    _yearList.removeWhere((element) => element.isEmpty);
  }

  _initializeLimits() {
    _startLimit = widget.startLimit ?? DateTime(1909, 12);
    _endLimit = widget.endLimit ?? DateTime(2100, 12);

    _startLimit = _startLimit.copyWith(
      day: 1,
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
    _endLimit = widget.endLimit ?? DateTime(2100, 12, 31);
    _endLimit = _endLimit.copyWith(
      day: _endLimit.lastDayOfMonth.day,
      hour: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      second: 0,
    );
  }
}
