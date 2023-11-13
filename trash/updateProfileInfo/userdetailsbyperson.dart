// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseExample extends StatelessWidget {
//   final String registrationId = "_registrationid"; // Replace with the actual document ID
//   final String username = "your_username"; // Replace with the actual username

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection(registrationId).doc(username).get(),
//       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

//           // Access the "Treatment Plan" field
//           String treatmentPlan = data["Treatment Plan"];

//           return Text("Treatment Plan: $treatmentPlan");
//         }

//         return CircularProgressIndicator(); // While data is loading
//       },
//     );
//   }
// }
