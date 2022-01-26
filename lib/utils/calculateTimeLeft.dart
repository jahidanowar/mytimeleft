String calculateTimeLeft(String dob) {
  final now = DateTime.now();
  final dateofbirth = DateTime.parse(dob);
  // Add 70 years to the date of birth
  final dateofdie = dateofbirth.add(Duration(days: 70 * 365));

  // Calculate the difference between now and dateofdie in days
  final difference = dateofdie.difference(now).inDays;
  // final birthToNow = now.difference(dateofbirth).inDays;

  return difference.toString();

  // setState(() {
  //   timeLeft = difference;
  //   daysSpent = birthToNow;
  // });
}
