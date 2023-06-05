<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Enhance your calendar experience with Flutter Calendar, a convenient plugin designed to enhance your calendar experience. With its powerful feature, Flutter Calendar allows you to effortlessly choose specific date from your calendar with just a few clicks

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.


## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

While calling the calendar widget would do the job but only `initialDateTime` field is required.

```dart
CalendarWidget(
    initalDateTime: DateTime.now(),
    onTap: (DateTime dateTime) {},
)
```

|Parameter|Description|
|-----------------------------------|--------------------------------------|
|initalDateTime   |is the initial DateTime calue required by the calendar to show that month|
|selectedDate    |Any day to be selected at the start, default would be the current day selected|
|startLimit      |is the start Limit Date for the calendar|
|endLimit |The end limit Date for the calendar|
|onTap |This will return `DateTime` instance on tap of the perticular day|
|monthYearOverlayValueDecorator |This is the decorator for the overlay that will have the option for selecting month or year while tapping from the header month name text in the main calendar|

## Additional information

For any conserns or quries do reach out the developer on `saadalvi@we-over-i.com` or `saadjavaidalvi@gmail.com`.
