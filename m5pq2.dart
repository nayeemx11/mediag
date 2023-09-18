import 'dart:io';

void main() {
  // print("Enter the dress code (casual or festive):");
  String dressCode = stdin.readLineSync()!;

  // print("Enter the temperature in Celsius:");
  int temperature = int.parse(stdin.readLineSync()!);

  String suggestedOutfit = suggestOutfit(dressCode, temperature);
  print(suggestedOutfit);
}

String suggestOutfit(String dressCode, int temperature) {
  if (dressCode == "casual" && temperature >= 15 && temperature <= 25) {
    return "Jeans and a light jacket.";
  } else if (dressCode == "festive" && temperature > 25) {
    return "Colorful dress and sandals.";
  } else {
    return "Wear what you're comfortable in.";
  }
}
