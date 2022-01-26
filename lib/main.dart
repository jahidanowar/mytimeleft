import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytimeleft/models/Prefs.dart';
import 'package:mytimeleft/resources/Strings.dart';
import 'package:mytimeleft/screens/home_screen.dart';
import 'package:mytimeleft/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytimeleft/utils/calculateTimeLeft.dart';
import 'package:mytimeleft/utils/generateQuotes.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    // The top level function, aka callbackDispatcher
    callbackDispatcher,
    // If enabled it will post a notification whenever
    // the task is running. Handy for debugging tasks
  );
  // Periodic task registration
  Workmanager().registerPeriodicTask("2", "simplePeriodicTask",
      frequency: Duration(hours: 12));
  runApp(TimeLeft());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Inside Callback Dispatcher");

    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_notif');
    var iOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: iOS);
    flip.initialize(settings);

    String dob = await getStringValue('dob');
    String tl = "";

    if (dob.isNotEmpty) {
      print("DOB exists: $dob");
      tl = calculateTimeLeft(dob);
      // Generate random number

      print("TL Generated: $tl");

      print("Notification generated");
    }

    _showNotificationWithDefaultSound(flip, tl, randomQuote());
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(
    FlutterLocalNotificationsPlugin flip, String tl, String body) async {
  print('Inside _showNotificationWithDefaultSound');
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'Quotes',
    'TimeLeftQuotes',
    'Send motivational quotes everyday',
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  var random = new Random();
  var randomNumber = random.nextInt(11212);

  if (tl.isNotEmpty) {
    await flip.show(
      randomNumber,
      'Hurry you have only $tl days left',
      body,
      platformChannelSpecifics,
    );
  } else {
    await flip.show(
      randomNumber,
      'TimeLeft: Quotes of the day',
      body,
      platformChannelSpecifics,
    );
  }
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
