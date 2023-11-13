// import 'package:flutter/material.dart';

// class UpdateUserDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Patient Information'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SectionTitle('Personal Information:'),
//               InfoTile('Full name', 'John Doe'),
//               InfoTile('Date of birth', 'January 1, 1990'),
//               InfoTile('Gender', 'Male'),
//               InfoTile('Address', '123 Main St, City, Country'),
//               InfoTile(
//                 'Contact information',
//                 'Phone: (123) 456-7890\nEmail: john.doe@example.com',
//               ),
//               SectionTitle('Identification:'),
//               InfoTile('Medical record number', '12345'),
//               InfoTile('Social security number', '123-45-6789'),
//               SectionTitle('Emergency Contacts:'),
//               InfoTile('Emergency Contact 1', 'Jane Doe - (111) 222-3333'),
//               InfoTile('Emergency Contact 2', 'Bob Smith - (444) 555-6666'),
//               SectionTitle('Insurance Information:'),
//               InfoTile('Health insurance provider', 'XYZ Insurance'),
//               InfoTile('Policy number', 'ABC123'),
//               SectionTitle('Medical History:'),
//               InfoTile('Past illnesses or medical conditions', 'None'),
//               InfoTile('Surgical history', 'Appendectomy in 2015'),
//               InfoTile('Allergies', 'Pollen, Penicillin'),
//               InfoTile('Medications currently being taken', 'Aspirin - 100mg, Daily'),
//               SectionTitle('Family Medical History:'),
//               InfoTile('Family member 1', 'Heart disease'),
//               InfoTile('Family member 2', 'Diabetes'),
//               SectionTitle('Social History:'),
//               InfoTile('Lifestyle factors', 'Non-smoker, Occasional drinker'),
//               InfoTile('Occupation', 'Engineer'),
//               InfoTile('Sexual history', 'Not applicable'),
//               SectionTitle('Chief Complaint:'),
//               InfoTile('Reason for visit', 'Fever and cough'),
//               SectionTitle('Present Illness:'),
//               InfoTile('Symptoms', 'Fever, cough, fatigue'),
//               SectionTitle('Physical Examination Findings:'),
//               InfoTile('Vital Signs', 'Blood pressure: 120/80\nHeart rate: 75 BPM'),
//               SectionTitle('Diagnostic Test Results:'),
//               InfoTile('Lab Results', 'Normal blood count'),
//               InfoTile('Imaging Results', 'No abnormalities found'),
//               SectionTitle('Treatment Plan:'),
//               InfoTile('Medications', 'Antibiotics - 500mg, 3 times a day'),
//               InfoTile('Surgical Procedures', 'None'),
//               SectionTitle('Progress Notes:'),
//               InfoTile('Notes', 'Patient improving with treatment'),
//               SectionTitle('Discharge Summary:'),
//               InfoTile('Summary', 'Recovered from fever and cough. Discharged.'),
//               SectionTitle('Follow-up Recommendations:'),
//               InfoTile('Follow-up', 'Visit primary care physician in 2 weeks'),
//               SectionTitle('Consent Forms:'),
//               InfoTile('Consent 1', 'Surgery consent - Signed'),
//               InfoTile('Consent 2', 'Treatment consent - Signed'),
//               SectionTitle('Advance Directives:'),
//               InfoTile('Directives', 'Living will - Yes\nDo not resuscitate - No'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;

//   SectionTitle(this.title);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: Colors.blue,
//         ),
//       ),
//     );
//   }
// }

// class InfoTile extends StatelessWidget {
//   final String title;
//   final String content;

//   InfoTile(this.title, this.content);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         title,
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(content),
//     );
//   }
// }



// // import 'package:flutter/material.dart';

// // class UpdateUserDetails extends StatelessWidget {
// //   const UpdateUserDetails({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("update users details"),
// //       ),
// //       body: ListTile(
// //           leading: Image.asset("assets/pullover.png"), // Provide the path to your image
// //           title: Text("Patient_name with reg_id", style: TextStyle(fontWeight: FontWeight.bold)),
// //           subtitle: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: <Widget>[
// //               Text("Fullname: ${"this field for full_name"}"),
// //               Text("Gender: ${"gender of patient"}"),

// //             ],
// //           ),,
// //     );
// //   }
// // }
