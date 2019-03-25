import 'dart:math';

import 'package:english_words/english_words.dart';

class Utils {
  Utils._();

  static String doSearch(String search) {
    if (search.contains("http") || search.contains("https")) {
      String regexString = r'.com/(\w+)(.*)?';
      RegExp regExp = RegExp(regexString);
      var matches = regExp.allMatches(search);

      print("REGEX: ${matches.length}");

      if (matches.length > 0) {
        var match = matches.elementAt(0);
        print("REGEX 1: ${match.group(0)}");
        print("REGEX UserName: ${match.group(1)}");
        print("REGEX 3: ${match.group(2)}");

        return match.group(1);
      } else {
        return search;
      }
    } else {
      return search;
    }
  }

  static String formatFollowersText(int count) {
    if (count >= 1000000000) {
      return (count / 1000000000)
              .toStringAsFixed(1)
              .replaceFirst(RegExp(r'/\.0$/'), '') +
          'G';
    }
    if (count >= 1000000) {
      return (count / 1000000)
              .toStringAsFixed(1)
              .replaceFirst(RegExp(r'/\.0$/'), '') +
          'M';
    }
    if (count >= 1000) {
      return (count / 1000)
              .toStringAsFixed(1)
              .replaceFirst(RegExp(r'/\.0$/'), '') +
          'K';
    }
    return count.toString();
  }

  static int getRandomNumber() {
    Random rnd = Random();
    int min = 5;
    int max = 10;
    return min + rnd.nextInt(max - min);
  }

  static String getRandomSearch() {
    return nouns.take(50).elementAt(Utils.getRandomNumber()).toLowerCase();
  }
}
