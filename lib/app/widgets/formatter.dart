final wordsPatternForAyahTitle = RegExp(
  r'\b(ayah|verse|audio)\b',
  caseSensitive: false,
);

final replacementsForTitle = {
  '[': '',
  ']': '',
  '(': '',
  ')': '',
  '|': '',
  '&amp;': '&',
  '&#039;': "'",
  '&quot;': '"',
};

String formatAyahTitle(String title) {
  final pattern = RegExp(
    replacementsForTitle.keys.map(RegExp.escape).join('|'),
  );

  var finalTitle = title
      .replaceAllMapped(
        pattern,
        (match) => replacementsForTitle[match.group(0)] ?? '',
      )
      .trim();

  finalTitle = finalTitle.replaceAll(wordsPatternForAyahTitle, '');

  return finalTitle;
}
