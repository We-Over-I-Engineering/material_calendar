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

Enhance your calendar experience with Flutter Calendar Widget, a convenient plugin designed to enhance your calendar experience. With its powerful feature, Flutter Calendar allows you to effortlessly choose specific date from your calendar with just a few clicks

![flutter_calendar_plugin](https://github.com/saadjavaidalvi-weoveri/flutter_calendar/assets/85175211/3ed8ec1c-c731-4613-947d-92c0c98c81e4)

## Features

You can use the calendar in your code for the either selecting a month or selecting a single day for any thing.


## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

As simple as using a Container widget just call the `CalendarWidget` and all done.
While calling the calendar widget would do the job but `initialDateTime` field is required.

```dart
CalendarWidget(
    initalDateTime: DateTime.now(),
    onTap: (DateTime dateTime) {}, // Optional
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

Incase of any issues or assistance please reach out on [Work Email](mailto:saad@we-over-i.com?subject=[Gilab]%20Source%Files%20for%20Wild) or [Personal Email](mailto:saadjavaidalvi@gmail.com?subject=[Gilab]%20Source%Files%20for%20Wild)
