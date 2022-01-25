import 'package:flutter/material.dart';
import 'package:mytimeleft/resources/Strings.dart';
import 'package:mytimeleft/screens/home_screen.dart';
import 'package:mytimeleft/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytimeleft/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  NotificationService ns = NotificationService("My Time Left", "Time Left");
  await ns.showNotification();
  runApp(TimeLeft());
}

class TimeLeft extends StatefulWidget {
  const TimeLeft({Key? key}) : super(key: key);

  @override
  _TimeLeftState createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.title,
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.chivoTextTheme(
        Theme.of(context).textTheme,
      )),
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }
}
