import 'package:flutter/material.dart';

/// The decorator for the overlay which with the month and year selection options
///
/// `color` is the background color for the circles
///
/// `borderColor` is to update border colors ot each circles
///
class CircularDecorator {
  Color? selectedColor;
  TextStyle? textStyle;
  Color? color;
  Color? borderColor;
  Color? textColor;
  Color? selectedTextColor;
  CircularDecorator({
    this.selectedColor,
    this.textStyle,
    this.color,
    this.borderColor,
    this.textColor,
    this.selectedTextColor,
  });

  CircularDecorator copyWith({
    Color? selectedColor,
    TextStyle? textStyle,
    Color? color,
    Color? borderColor,
    Color? textColor,
    Color? selectedTextColor,
  }) {
    return CircularDecorator(
      selectedColor: selectedColor ?? this.selectedColor,
      textStyle: textStyle ?? this.textStyle,
      color: color ?? this.color,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
    );
  }

  @override
  String toString() {
    return 'CircularDecorator(selectedColor: $selectedColor, textStyle: $textStyle, color: $color, borderColor: $borderColor, textColor: $textColor, selectedTextColor: $selectedTextColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CircularDecorator &&
        other.selectedColor == selectedColor &&
        other.textStyle == textStyle &&
        other.color == color &&
        other.borderColor == borderColor &&
        other.textColor == textColor &&
        other.selectedTextColor == selectedTextColor;
  }

  @override
  int get hashCode {
    return selectedColor.hashCode ^
        textStyle.hashCode ^
        color.hashCode ^
        borderColor.hashCode ^
        textColor.hashCode ^
        selectedTextColor.hashCode;
  }
}
