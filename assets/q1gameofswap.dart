import 'dart:io';

void main() {
  // Read input
  List<String> input = stdin.readLineSync()!.split(" ");
  int num1 = int.parse(input[0]);
  int num2 = int.parse(input[1]);

  // Print original values
  print("Before swapping: num1 = $num1, num2 = $num2");
  
  // Swap values
  int temp = num1;
  num1 = num2;
  num2 = temp;

  // Print swapped values
  print("After swapping: num1 = $num1, num2 = $num2");
}
