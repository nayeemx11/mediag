import 'dart:io';

void main() {
  // Read input values
  List<int> values = stdin.readLineSync()!.split(' ').map(int.parse).toList();
  String order = stdin.readLineSync()!;

  // Create a map to store the current values of A, B, and C
  Map<String, int> valueMap = {'A': values[0], 'B': values[1], 'C': values[2]};
  Map<String, int> valueResMap = {'A': 0, 'B': 0, 'C': 0};

  // Perform swaps according to the given order
  for (int i = 0; i < order.length; i++) {
    switch (order[i]) {
      case 'A':
        valueResMap['B'] = valueMap['A']!;
        break;
      case 'B':
        valueResMap['C'] = valueMap['B']!;
        break;
      case 'C':
        valueResMap['A'] = valueMap['C']!;
        break;
    }
  }

  // Print the values in the given order
  for (int i = 0; i < order.length; i++) {
    switch (order[i]) {
      case 'A':
        stdout.write('${valueResMap['A']} ');
        break;
      case 'B':
        stdout.write('${valueResMap['B']} ');
        break;
      case 'C':
        stdout.write('${valueResMap['C']} ');
        break;
    }
  }
}
