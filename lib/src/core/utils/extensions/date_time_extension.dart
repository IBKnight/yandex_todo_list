extension DateFormatter on DateTime {
  String formatDate() {
    const List<String> months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];

    String day = this.day.toString();
    String month = months[this.month - 1];
    String year = this.year.toString();

    return '$day $month $year';
  }
}
