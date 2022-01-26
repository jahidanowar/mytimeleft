import 'dart:math';

List<String> quotes = [
  '"The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart."',
  '"The way to get started is to quit talking and begin doing."',
  '"The pessimist sees difficulty in every opportunity. The optimist sees the opportunity in every difficulty."',
  '"Don\'t Let Yesterday Take Up Too Much Of Today."',
  '"I attribute my success to this: I never gave or took any excuse."',
  '"You miss 100% of the shots you don\'t take."',
];

String randomQuote() {
  var random = new Random();
  int randomNumber = random.nextInt(quotes.length);
  return quotes[randomNumber];
}
