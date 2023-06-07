## Your clean and simple calendar companion


Enhance your calendar experience with Flutter Calendar Widget, a convenient plugin designed to enhance your calendar experience.


![flutter_calendar_plugin](https://github.com/saadjavaidalvi-weoveri/flutter_calendar/assets/85175211/3ed8ec1c-c731-4613-947d-92c0c98c81e4)

## Features

You can use the calendar for either selecting a month or a single day in the most clean way possible. ✨


## Getting started

Import the plugin and call the `CalendarWidget` and you are good to go... 🎉

```yaml
# add this line to your dependencies
material_calendar: ^0.0.4
```

```dart
export 'package:material_calendar/widgets/calendar_widget.dart';
```

## Usage

As simple as using a Container widget just call the `CalendarWidget`.

Although `initialDateTime` is required to show the inital calendar month.


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
<!-- |monthYearOverlayValueDecorator |This is the decorator for the overlay that will have the option for selecting month or year while tapping from the header month name text in the main calendar| -->

## Additional information

Incase of any issues or assistance please reach out on [saad@we-over-i.com](mailto:saad@we-over-i.com) or [saadjavaidalvi@gmail.com](mailto:saadjavaidalvi@gmail.com)

Have Fun!