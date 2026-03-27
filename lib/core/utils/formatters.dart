import 'package:intl/intl.dart';

final NumberFormat _currencyFormat = NumberFormat.currency(
  locale: 'en_CA',
  symbol: r'$',
  decimalDigits: 0,
);
final DateFormat _longDateFormat = DateFormat('EEE, MMM d');

String formatCurrency(num amount) => _currencyFormat.format(amount);

String formatRating(double rating) => rating.toStringAsFixed(1);

String formatLongDate(DateTime date) => _longDateFormat.format(date);
