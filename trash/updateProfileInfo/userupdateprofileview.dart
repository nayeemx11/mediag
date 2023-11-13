// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserProfilePage extends StatefulWidget {
//   final String _email;
//   // final String _password;
//   final String _reegitratrionid;
//   // final String _login_as;

//   UserProfilePage(this._email, this._reegitratrionid);

//   @override
//   _UserProfilePageState createState() =>
//       _UserProfilePageState(_email, _reegitratrionid);
// }

// class _UserProfilePageState extends State<UserProfilePage> {
  

//   final String _email;
//   // final String _password;
//   final String _reegitratrionid;
//   // final String _login_as;

//   User? _user; // Updated the type to User?

//   _UserProfilePageState(this._email, this._reegitratrionid);

//   @override
//   void initState() {
//     super.initState();
//     // Call the method to perform automatic login
//     // performAutomaticLogin();
//   }

//   // // Method to perform automatic login
//   // void performAutomaticLogin() async {
//   //   try {
//   //     UserCredential userCredential =
//   //         await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //       email: _email,
//   //       password: _password,
//   //     );

//   //     _user = userCredential.user; // Assign the User object

//   //     if (_user != null) {
//   //       // Successfully logged in, you can now proceed to update Firestore or perform other actions
//   //       // ...
//   //     }
//   //   } catch (e) {
//   //     // Handle login errors
//   //     print('Login error: $e');
//   //   }
//   // }

//   void showCongratulationSnackbar(BuildContext context) {
//     final snackBar = SnackBar(
//       content: Text('Congratulations! Information updated successfully.'),
//       duration: Duration(seconds: 3),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   // Method to update information in Firebase Firestore
//   void updateFirebaseFirestore() {
//     FirebaseFirestore.instance
//         .collection(_reegitratrionid) // Use your collection name here
//         .doc(_email) // Use the document ID (e.g., user's email) as needed
//         .set({
//       'Full name': _fullNameController.text,
//       'Date of birth': _dobController.text,
//       'Gender': _genderController.text,
//       'Address': _addressController.text,
//       'Contact information': _contactInfoController.text,
//       'Medical record number': _medicalRecordNumberController.text,
//       'Social security number': _ssnController.text,
//       'Emergency Contacts': _emergencyContactsController.text,
//       'Insurance Provider': _insuranceProviderController.text,
//       'Medical History': _medicalHistoryController.text,
//       'Family Medical History': _familyMedicalHistoryController.text,
//       'Social History': _socialHistoryController.text,
//       'Chief Complaint': _chiefComplaintController.text,
//       'Present Illness': _presentIllnessController.text,
//       'Physical Examination Findings': _physicalExamController.text,
//       'Diagnostic Test Results': _testResultsController.text,
//       'Treatment Plan': _treatmentPlanController.text,
//       'Progress Notes': _progressNotesController.text,
//       'Discharge Summary': _dischargeSummaryController.text,
//       'Follow-up Recommendations': _followUpRecommendationsController.text,
//       'Consent Forms': _consentFormsController.text,
//       'Advance Directives': _advanceDirectivesController.text,
//       // Add other fields as needed, mapping to corresponding controllers
//     }).then((_) {
//       // Show a success message, navigate back, or perform other actions
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Information updated successfully'),
//       ));
//     }).catchError((error) {
//       // Handle errors, show an error message, or perform other actions
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error updating information: $error'),
//       ));
//     });
//   }

//   TextEditingController _fullNameController = TextEditingController();
//   TextEditingController _dobController = TextEditingController();
//   TextEditingController _genderController = TextEditingController();
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _contactInfoController = TextEditingController();
//   TextEditingController _medicalRecordNumberController =
//       TextEditingController();
//   TextEditingController _ssnController = TextEditingController();
//   TextEditingController _emergencyContactsController = TextEditingController();
//   TextEditingController _insuranceProviderController = TextEditingController();
//   TextEditingController _medicalHistoryController = TextEditingController();
//   TextEditingController _familyMedicalHistoryController =
//       TextEditingController();
//   TextEditingController _socialHistoryController = TextEditingController();
//   TextEditingController _chiefComplaintController = TextEditingController();
//   TextEditingController _presentIllnessController = TextEditingController();
//   TextEditingController _physicalExamController = TextEditingController();
//   TextEditingController _testResultsController = TextEditingController();
//   TextEditingController _treatmentPlanController = TextEditingController();
//   TextEditingController _progressNotesController = TextEditingController();
//   TextEditingController _dischargeSummaryController = TextEditingController();
//   TextEditingController _followUpRecommendationsController =
//       TextEditingController();
//   TextEditingController _consentFormsController = TextEditingController();
//   TextEditingController _advanceDirectivesController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16.0),
//               children: <Widget>[
//                 Text(
//                   'Personal Information:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextFormField(
//                   controller: _fullNameController,
//                   decoration: InputDecoration(labelText: 'Full name'),
//                 ),
//                 TextFormField(
//                   controller: _dobController,
//                   decoration: InputDecoration(labelText: 'Date of birth'),
//                 ),
//                 TextFormField(
//                   controller: _genderController,
//                   decoration: InputDecoration(labelText: 'Gender'),
//                 ),
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(labelText: 'Address'),
//                 ),
//                 TextFormField(
//                   controller: _contactInfoController,
//                   decoration: InputDecoration(labelText: 'Contact information'),
//                 ),
//                 Text(
//                   'Identification:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextFormField(
//                   controller: _medicalRecordNumberController,
//                   decoration:
//                       InputDecoration(labelText: 'Medical record number'),
//                 ),
//                 TextFormField(
//                   controller: _ssnController,
//                   decoration: InputDecoration(
//                       labelText:
//                           'Social security number or other identification numbers'),
//                 ),
//                 Text(
//                   'Emergency Contacts:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextFormField(
//                   controller: _emergencyContactsController,
//                   decoration: InputDecoration(
//                       labelText:
//                           'Names and contact information of individuals to notify'),
//                 ),
//                 Text(
//                   'Insurance Information:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextFormField(
//                   controller: _insuranceProviderController,
//                   decoration: InputDecoration(
//                       labelText: 'Health insurance provider and policy number'),
//                 ),
//                 // Medical History
//                 TextFormField(
//                   controller: _medicalHistoryController,
//                   decoration: InputDecoration(labelText: 'Medical History'),
//                 ),
//                 // Family Medical History
//                 TextFormField(
//                   controller: _familyMedicalHistoryController,
//                   decoration:
//                       InputDecoration(labelText: 'Family Medical History'),
//                 ),
//                 // Social History
//                 TextFormField(
//                   controller: _socialHistoryController,
//                   decoration: InputDecoration(labelText: 'Social History'),
//                 ),

//                 // Chief Complaint
//                 TextFormField(
//                   controller: _chiefComplaintController,
//                   decoration: InputDecoration(labelText: 'Chief Complaint'),
//                 ),

//                 // Present Illness
//                 TextFormField(
//                   controller: _presentIllnessController,
//                   decoration: InputDecoration(labelText: 'Present Illness'),
//                 ),

//                 // Physical Examination Findings
//                 TextFormField(
//                   controller: _physicalExamController,
//                   decoration: InputDecoration(
//                       labelText: 'Physical Examination Findings'),
//                 ),

//                 // Diagnostic Test Results
//                 TextFormField(
//                   controller: _testResultsController,
//                   decoration:
//                       InputDecoration(labelText: 'Diagnostic Test Results'),
//                 ),

//                 // Treatment Plan
//                 TextFormField(
//                   controller: _treatmentPlanController,
//                   decoration: InputDecoration(labelText: 'Treatment Plan'),
//                 ),

//                 // Progress Notes
//                 TextFormField(
//                   controller: _progressNotesController,
//                   decoration: InputDecoration(labelText: 'Progress Notes'),
//                 ),

//                 // Discharge Summary
//                 TextFormField(
//                   controller: _dischargeSummaryController,
//                   decoration: InputDecoration(labelText: 'Discharge Summary'),
//                 ),

//                 // Follow-up Recommendations
//                 TextFormField(
//                   controller: _followUpRecommendationsController,
//                   decoration:
//                       InputDecoration(labelText: 'Follow-up Recommendations'),
//                 ),

//                 // Consent Forms
//                 TextFormField(
//                   controller: _consentFormsController,
//                   decoration: InputDecoration(labelText: 'Consent Forms'),
//                 ),

//                 // Advance Directives
//                 TextFormField(
//                   controller: _advanceDirectivesController,
//                   decoration: InputDecoration(labelText: 'Advance Directives'),
//                 ),

//                 // Add similar TextFormField widgets for the remaining fields
//               ],
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               updateFirebaseFirestore();
//               showCongratulationSnackbar(context);
//             },
//             child: Container(
//               height: 80, // Increase the height as needed
//               decoration: BoxDecoration(
//                 color: Colors.red, // Background color of the container
//                 borderRadius: BorderRadius.circular(40), // Circular corners
//               ),
//               child: Center(
//                 child: Text(
//                   "Update information",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
