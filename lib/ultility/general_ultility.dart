class GeneralUltility {
  static bool isTheSameWeekAsToday(DateTime date) {
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    int diffWeekDay = date.weekday - today.weekday;
    Duration diffTime = date.difference(today);
    return ((diffWeekDay >= 0) &&
        ((diffTime.inDays) < 7) &&
        (diffTime.inDays > 0));
  }

  static String fileSizeConvert(int size) {
    double convertedSize = size / 1024;
    if (convertedSize < 1024) {
      return '${convertedSize.toStringAsFixed(2)} KB';
    } else if (convertedSize < 1024 * 1024) {
      return '${(convertedSize / 1024).toStringAsFixed(2)} MB';
    } else if (convertedSize < 1024 * 1024 * 1024) {
      return '${(convertedSize / (1024 * 1024)).toStringAsFixed(2)} GB';
    } else {
      return '${(convertedSize / (1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }
}
