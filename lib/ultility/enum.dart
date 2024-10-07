enum Frequency {
  day('Day'),
  weekday('Weekday'),
  week('Week'),
  month('Month'),
  year('Year');

  const Frequency(this.value);
  final String value;
}

enum SortType {
  important('important'),
  dueDate('due date'),
  myDay('my day'),
  alphabetically('alphabetically'),
  createDate('create date');

  const SortType(this.value);
  final String value;
}
