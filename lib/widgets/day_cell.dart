import 'package:flutter/material.dart';
import '../models/cell_design_model.dart';

/// A single cell widget of the calendar with the date
///
/// `dateTime` is the required field and the rest will only show a simple clean white background rounded border box with the date number inside
///
/// `currentDay` variable is select that cell by making it darker
///
/// You can always change the decorations of the cell by using `cellDecorator` or to change the currentDay decorator by `currentDayDec`
/// `isWeekend` boolean will result on changing the decoration for the cell

class DayCell extends StatefulWidget {
  final String number;
  final bool currentDay;
  final bool selectedDay;
  final bool isWeekend;
  final CalendarCellDecorator? cellDecorator;
  final CalendarCellDecorator? currentDayDec;
  final bool showOutOfMonthCells;
  final Function(DateTime)? onTap;
  final DateTime dateTime;
  final bool dayInMonth;

  const DayCell({
    Key? key,
    this.number = '1',
    this.currentDay = false,
    this.selectedDay = false,
    this.isWeekend = false,
    this.dayInMonth = true,
    this.onTap,
    this.cellDecorator,
    this.showOutOfMonthCells = false,
    required this.dateTime,
    this.currentDayDec,
  }) : super(key: key);

  @override
  State<DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<DayCell> {
  @override
  Widget build(BuildContext context) {
    return !widget.dayInMonth && !widget.showOutOfMonthCells
        ? SizedBox(
            height: widget.cellDecorator?.height ?? 60,
            width: widget.cellDecorator?.width ?? 52,
          )
        : Opacity(
            opacity: widget.dayInMonth ? 1 : .5,
            child: GestureDetector(
              onTap: () {
                if (widget.dayInMonth) {
                  widget.onTap!(widget.dateTime);
                  setState(() {});
                }
              },
              child: Container(
                margin: widget.cellDecorator?.margin,
                padding: widget.cellDecorator?.padding,
                height: widget.cellDecorator?.height ?? 60,
                width: widget.cellDecorator?.width ?? 52,
                decoration: BoxDecoration(
                  color: widget.cellDecorator?.color ??
                      (widget.dayInMonth
                          ? widget.isWeekend
                              ? const Color(0xffF1F0F0)
                              : Colors.white
                          : const Color(0xffF6F6F6)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: widget.currentDay
                            ? widget.currentDayDec?.color
                            : Colors.white,
                        border: widget.selectedDay || widget.currentDay
                            ? Border.all(
                                color: Colors.black,
                                width: 2,
                              )
                            : Border.all(
                                color: Colors.transparent,
                                width: 2,
                              ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Text(
                          widget.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.currentDay
                                ? widget.currentDayDec?.contentColor
                                : widget.cellDecorator?.contentColor ??
                                    (widget.currentDay
                                        ? Colors.white
                                        : Colors.black),
                            height: 1.3,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
