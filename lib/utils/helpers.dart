/*import 'package:intl/intl.dart';

// Format a DateTime object to a string in a specified format
String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
  final DateFormat dateFormat = DateFormat(format);
  return dateFormat.format(date);
}

// Parse a string to a DateTime object
DateTime parseDate(String dateStr, {String format = 'yyyy-MM-dd'}) {
  final DateFormat dateFormat = DateFormat(format);
  return dateFormat.parse(dateStr);
}

// Validate email format
bool isValidEmail(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$',
  );
  return emailRegExp.hasMatch(email);
}

// Validate password strength
bool isValidPassword(String password) {
  // At least 8 characters, one uppercase letter, one lowercase letter, one digit
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  return passwordRegExp.hasMatch(password);
}

// Convert a duration in seconds to a human-readable string
String formatDuration(int seconds) {
  final Duration duration = Duration(seconds: seconds);
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes % 60;
  final int secs = duration.inSeconds % 60;

  return '${hours > 0 ? '$hours h ' : ''}'
      '${minutes > 0 ? '$minutes m ' : ''}'
      '${secs > 0 ? '$secs s' : ''}';
}

// Generate a unique ID for a trip or container
String generateUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

// Display a snackbar message
void showSnackbar(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
    ),
  );
}

// Show an alert dialog
Future<void> showAlertDialog(BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}*/
