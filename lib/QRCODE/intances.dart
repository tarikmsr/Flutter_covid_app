import 'data.dart';

MyData myData= MyData();

String formatDate(DateTime now) {
  return "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
}
