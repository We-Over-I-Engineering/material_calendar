import 'package:flutter/material.dart';

/// The model for the decoration of Whole calendar widget
///
/// For now it only supports the `backgroundColor` field
class CalendarDecorator {
  Color? backgroundColor;
  CalendarDecorator({
    this.backgroundColor,
  });

  CalendarDecorator copyWith({
    Color? backgroundColor,
  }) {
    return CalendarDecorator(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  String toString() => 'CalendarDecorator(backgroundColor: $backgroundColor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarDecorator &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode => backgroundColor.hashCode;
}
