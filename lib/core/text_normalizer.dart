class TextNormalizer {
  const TextNormalizer._();

  static const wordChars = 'a-z0-9а-я';

  static const _fold = <String, String>{
    'ə': 'e',
    'ş': 's',
    'ç': 'c',
    'ğ': 'g',
    'ö': 'o',
    'ü': 'u',
    'ı': 'i',
    'á': 'a',
    'à': 'a',
    'â': 'a',
    'ä': 'a',
    'ã': 'a',
    'å': 'a',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'í': 'i',
    'ì': 'i',
    'î': 'i',
    'ï': 'i',
    'ó': 'o',
    'ò': 'o',
    'ô': 'o',
    'õ': 'o',
    'ú': 'u',
    'ù': 'u',
    'û': 'u',
    'ñ': 'n',
    'ß': 'ss',
    'ё': 'е',
  };

  static final _nonWord = RegExp('[^$wordChars]');
  static final _spaces = RegExp(' +');
  static final _eNumber = RegExp('(?<![$wordChars])[eе]\\s?(\\d{3,4}[a-i]?)(?!\\d)');

  static String normalize(String input) {
    final lowered =
        input.replaceAll('İ', 'i').replaceAll('I', 'i').toLowerCase();

    final folded = StringBuffer();
    for (final rune in lowered.runes) {
      final char = String.fromCharCode(rune);
      folded.write(_fold[char] ?? char);
    }

    final spaced = folded
        .toString()
        .replaceAll(_nonWord, ' ')
        .replaceAll(_spaces, ' ')
        .trim();

    return spaced.replaceAllMapped(_eNumber, (m) => 'e${m[1]}');
  }
}