formetdata(DateTime date) {
// if today
  if (date.day == DateTime.now().day &&
      date.month == DateTime.now().month &&
      date.year == DateTime.now().year) {
    // now time today
    return 'Today ${date.hour > 9 ? date.hour : '0${date.hour}'}:${date.minute > 9 ? date.minute : '0${date.minute}'}';
  }
  // if yesterday
  if (date.day == DateTime.now().day - 1 &&
      date.month == DateTime.now().month &&
      date.year == DateTime.now().year) {
    return 'Yesterday ${date.hour > 9 ? date.hour : '0${date.hour}'}:${date.minute > 9 ? date.minute : '0${date.minute}'}';
  }
}
