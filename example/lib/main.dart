import 'package:flutter/material.dart';
import 'package:custom_calendar/widgets/calendar_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarWidget(
        initalDateTime: DateTime.now(),
        headerMargins: const EdgeInsets.only(
          top: 50,
        ),
        /* calendarDecorator: CalendarDecorator(
          backgroundColor: Colors.white,
        ),
        monthYearOverlayValueDecorator: CircularDecorator(
          textColor: Colors.black,
          selectedColor: Colors.black,
          selectedTextColor: Colors.white,
        ), */
        onTap: (DateTime dateTime) {
          /* if (kDebugMode) {
            print(dateTime);
          } */
        },
      ),
    );
  }
}
