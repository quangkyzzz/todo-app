enum Freaquency {
  day('Day'),
  week('Week'),
  month('Month'),
  year('Year');

  const Freaquency(this.value);
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
