import 'dart:io';

void main() {
  // print("Enter the arithmetic equation (e.g., '5 + 3'): ");
  String input = stdin.readLineSync()!;

  // Split the input into components: operand1, operator, operand2
  List<String> components = input.split(' ');
  if (components.length != 3) {
    // print("Invalid input format. Please enter an equation like '5 + 3'.");
    return;
  }

  double operand1, operand2;
  String operator = components[1];

  try {
    operand1 = double.parse(components[0]);
    operand2 = double.parse(components[2]);
  } catch (e) {
    // print("Invalid operand(s). Please enter valid numbers.");
    return;
  }

  var result;

  switch (operator) {
    case '+':
      result = operand1.toInt() + operand2.toInt();
      break;
    case '-':
      result = operand1.toInt() - operand2.toInt();
      break;
    case '*':
      result = operand1.toInt() * operand2.toInt();
      break;
    case '/':
      if (operand2 != 0) {
        result = operand1 ~/ operand2;
      } else {
        print("Division by zero is not allowed.");
        return;
      }
      break;
    default:
      print("Invalid operator. Please use '+', '-', '*', or '/'.");
      return;
  }

  // print("$input = $result");
  print("$result");
}
