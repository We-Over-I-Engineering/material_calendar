import 'package:flutter/material.dart';

class CalendarCellDecorator {
  Color? color;
  Color? contentColor;
  double? height;
  double? width;
  EdgeInsets? margin;
  EdgeInsets? padding;
  BorderRadiusGeometry? borderRadius;

  CalendarCellDecorator({
    this.color,
    this.contentColor,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
  });

  CalendarCellDecorator copyWith({
    Color? color,
    Color? contentColor,
    double? height,
    double? width,
    EdgeInsets? margin,
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
  }) {
    return CalendarCellDecorator(
      color: color ?? this.color,
      contentColor: contentColor ?? this.contentColor,
      height: height ?? this.height,
      width: width ?? this.width,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  String toString() {
    return 'CalendarCellDecorator(color: $color, contentColor: $contentColor, height: $height, width: $width, margin: $margin, padding: $padding, borderRadius: $borderRadius)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarCellDecorator &&
        other.color == color &&
        other.contentColor == contentColor &&
        other.height == height &&
        other.width == width &&
        other.margin == margin &&
        other.padding == padding &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        contentColor.hashCode ^
        height.hashCode ^
        width.hashCode ^
        margin.hashCode ^
        padding.hashCode ^
        borderRadius.hashCode;
  }
}
