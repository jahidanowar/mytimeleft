import 'package:flutter/material.dart';
import 'package:mytimeleft/models/Prefs.dart';
import 'package:mytimeleft/resources/Strings.dart';
import 'package:mytimeleft/screens/splash_screen.dart';
import 'package:mytimeleft/widgets/blur_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String dob;
  int? timeLeft;
  int? daysSpent;

  @override
  void initState() {
    _setDob();

    super.initState();
  }

  _setDob() async {
    final prevDob = await getStringValue('dob');
    setState(() {
      dob = prevDob;
    });

    _calculateTimeLeft();
  }

  _calculateTimeLeft() {
    if (dob.isEmpty) {
      return;
    }
    final now = DateTime.now();
    final dateofbirth = DateTime.parse(this.dob);
    // Add 60 years to the date of birth
    final dateofdie = dateofbirth.add(Duration(days: 70 * 365));

    // Calculate the difference between now and dateofdie in days
    final difference = dateofdie.difference(now).inDays;
    final birthToNow = now.difference(dateofbirth).inDays;

    setState(() {
      timeLeft = difference;
      daysSpent = birthToNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/home_screen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      BlurBox(
                        height: 200,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              timeLeft.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              Strings.timeLeft.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      BlurBox(
                        height: 200,
                        alignment: Alignment.center,
                        backgroundColor: Colors.white.withOpacity(0.09),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              daysSpent.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              Strings.timeSpent.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('dob');
                    Navigator.pushNamed(context, SplashScreen.routeName);
                  },
                  child: BlurBox(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      Strings.changeDob.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
