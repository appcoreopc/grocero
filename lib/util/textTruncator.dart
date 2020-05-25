class TextUtil {
  static String getLayoutFriendlyText(String source, int maxLength) {
    if (source.length > maxLength + 3) {
      return source.substring(0, maxLength) + "...";
    }
    return source;
  }
}
