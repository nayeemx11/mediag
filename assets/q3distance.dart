import 'dart:io';
import 'dart:math';

void main() {
  // Read input
  List<String>? firstpoint = stdin.readLineSync()!.split(" ");
  List<String>? secondpoint = stdin.readLineSync()!.split(" ");

  int x1 = int.parse(firstpoint[0]);
  int y1 = int.parse(firstpoint[1]);

  int x2 = int.parse(secondpoint[0]);
  int y2 = int.parse(secondpoint[1]);

  double dis = sqrt((pow((x2-x1), 2)) + (pow((y2 - y1), 2)));
  print("Distance: ${dis.toStringAsFixed(2)}");
  
}
