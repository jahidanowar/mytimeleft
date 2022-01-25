import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytimeleft/screens/home_screen.dart';
import 'package:mytimeleft/services/notification_service.dart';
import 'package:mytimeleft/widgets/blur_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mytimeleft/models/Prefs.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime? dateofBirth;
  String? dob;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  checkFirstTime() async {
    try {
      print("Checking first time");
      dob = await getStringValue('dob');
      print(dob);
      if (dob != null) {
        return Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_screen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  BlurBox(
                    backgroundColor: Colors.black.withOpacity(0.1),
                    borderColor: Colors.white.withOpacity(0.5),
                    alignment: Alignment.center,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'When did you \nfirst cry?'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDatePickerMode: DatePickerMode.year,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                    builder: (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Colors.purple,
                                            onPrimary: Colors.white,
                                            surface: Colors.transparent,
                                            onSurface: Colors.white,
                                          ),
                                          dialogBackgroundColor:
                                              Colors.transparent,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 100, horizontal: 30),
                                            child: BlurBox(
                                              child: child!,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                .then((value) =>
                                    setState(() => dateofBirth = value));
                          },
                          child: Center(
                            child: Text(
                              dateofBirth != null
                                  ? dateofBirth!.toString().split(' ')[0]
                                  : 'Tap to select date',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Material Date Picker
                  InkWell(
                    onTap: () {
                      _goToHome(context);
                    },
                    child: BlurBox(
                      alignment: Alignment.center,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      height: 50,
                      child: Text(
                        'Continue'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _goToHome(BuildContext context) async {
    if (dateofBirth == null) {
      // Show Snackbar with error
      final snakbar = SnackBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.purple,
          content: Text(
            'Please select a date',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
      return;
    }
    // Store the date of birth in shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('dob', dateofBirth!.toString());
      Navigator.pushNamed(context, HomeScreen.routeName);
    }).catchError((onError) {
      print(onError);
    });
  }
}
