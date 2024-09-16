class GeneralUltility {
  bool isTheSameWeekAsToday(DateTime date) {
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
}
