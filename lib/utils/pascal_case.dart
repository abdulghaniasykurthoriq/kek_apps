String toPascalCase(String name) {
  List<String> words = name.split(' ');
  String result = '';

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (word.isNotEmpty) {
      if (i > 0) {
        result += ' ';
      }

      result += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
  }

  return result;
}
