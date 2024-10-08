import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  required DateTime? initialDate,
}) async {
  if ((initialDate != null) && (initialDate.isBefore(DateTime.now()))) {
    initialDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
    );
  }
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ??
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          9,
        ),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
  if (selectedDate == null) return null;

  if (!context.mounted) return null;

  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(
      initialDate ??
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            9,
          ),
    ),
  );

  if (selectedTime == null) return null;

  return DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );
}
