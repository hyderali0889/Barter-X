import 'dart:math';

Set<int> generateRandomNumbers(int count, int min, int max) {
  Set<int> randomNumbers = <int>{};
  Random random = Random();

  while (randomNumbers.length < count) {
    int randomNumber = min + random.nextInt(max - min + 1);
    randomNumbers.add(randomNumber);
  }

  return randomNumbers;
}