import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:mytimeleft/models/Prefs.dart';
import 'package:mytimeleft/resources/Strings.dart';
import 'package:mytimeleft/screens/home_screen.dart';
import 'package:mytimeleft/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytimeleft/services/notification_service.dart';
import 'package:mytimeleft/utils/calculateTimeLeft.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  final cron = Cron();
  cron.schedule(Schedule.parse('0 6 * * *'), () async {
    String? dob = await getStringValue('dob');
    print(dob);
    if (dob != null && dob.isNotEmpty) {
      Map<String, String>? tl = calculateTimeLeft(dob);
      if (tl != null) {
        print(tl["timeLeft"]);
        NotificationService ns = NotificationService(
            'Hurry you have only ${tl["timeLeft"]} days left',
            'The most precious resource we all have is time.');
        await ns.showNotification();
      }
    }
  });

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
