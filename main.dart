import 'dart:io';

void removeWrongLength(List<String> words) {
  words.removeWhere((word) => word.length != 5);
}

bool hasDuplicateLetters(String word) {
  for (var i = 0; i < word.length - 1; i++) {
    for (var t = i + 1; t < word.length; t++) {
      if (word[i] == word[t]) return true;
    }
  }
  return false;
}

void removeWordsWithRepeatedLetters(List<String> words) {
  words.removeWhere(hasDuplicateLetters);
}

bool shareLetters(String a, String b) {
  for (var i = 0; i < a.length; i++) {
    if (b.contains(a[i])) {
      return true;
    }
  }
  return false;
}

class node {
  String word = "";
  node(List<String> words, int depth, int index, String word, File output) {
    word += words[index];
    if (depth > 0) {
      for (int i = index; i < words.length; i++) {
        if(!shareLetters(word, words[i]))
          node(words, depth - 1, i, word, output);
      }
    } else {
      print(word);
      output.writeAsStringSync((word + "\n"), mode: FileMode.append);
    }
  }
}

void main() {
  var dictionary = File("words.txt");
  var output = File("out.txt");
  List<String> words = dictionary.readAsLinesSync();
  removeWrongLength(words);
  removeWordsWithRepeatedLetters(words);

  for(int i = 0; i < words.length; i++)
  {
    node(words, 4, i, "", output);
    print(i);
  }
}
