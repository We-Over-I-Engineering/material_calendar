import 'package:flutter/material.dart';
import '../models/cell_design_model.dart';

/// Widget for a single cell of the calendar
///
class DayCell extends StatefulWidget {
  final String number;
  final bool currentDay;
  final bool selectedDay;
  final String headerText;
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
    this.headerText = '',
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
                              : Colors.white /* const Color(0xffF6F6F6) */
                          : const Color(0xffF6F6F6)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    /* Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          // cmargin(
                          //   left: 2,
                          // ),
                          child: SizedBox(
                            height: (13),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 2),
                          // cmargin(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: widget.headerText.isEmpty
                                    ? null
                                    : const EdgeInsets.only(
                                        left: 6,
                                        right: 4,
                                      ),
                                child: AutoSizeText(
                                  widget.headerText.isEmpty
                                      ? ''
                                      : widget.headerText,
                                  /* style: MyCustomTextStyles()
                                      .paragrahSmall
                                      .copyWith(
                                        color: widget
                                                .cellDecorator?.contentColor ??
                                            Colors.white,
                                        height: HelperMethods()
                                            .getMyDynamicHeight(1),
                                      ), */
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ), */
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
