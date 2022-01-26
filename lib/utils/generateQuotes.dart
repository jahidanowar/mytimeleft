import 'dart:math';

List<String> quotes = [
  'The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.',
  'The way to get started is to quit talking and begin doing.',
  'The pessimist sees difficulty in every opportunity. The optimist sees the opportunity in every difficulty.',
  'Don\'t Let Yesterday Take Up Too Much Of Today.',
  'I attribute my success to this: I never gave or took any excuse.',
  'You miss 100% of the shots you don\'t take.',
  'A person who never made a mistake never tried anything new.',
  'The best revenge is massive success.',
  'I have not failed. I\'ve just found 10,000 ways that won\'t work.',
  'The only person who never makes mistakes is the person who never tries anything.',
  'The best way to predict your future is to create it.',
  'The best way to find yourself is to lose yourself in the service of others.',
  'The best way to keep a secret is to tell everyone.',
  'The best way to find a good teacher is to look for one who is already a good teacher.',
  'I wish it need not have happened in my time'
];

String randomQuote() {
  var random = new Random();
  int randomNumber = random.nextInt(quotes.length);
  return quotes[randomNumber];
}
