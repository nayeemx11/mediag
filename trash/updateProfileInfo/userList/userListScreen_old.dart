// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mediag/screens/updateuserdetails/updateusersdetails.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../authentication/login_screen.dart';
// import '../splash/splash_screen.dart';

// class UserListScreen extends StatelessWidget {
//   String email = '';
//   String password = '';
//   String user_name = '';
//   String login_as = '';
//   String reegitratrionid = '';

//   Map<String, dynamic>?
//       lastDocumentData; // To store the data from the last document

//   UserListScreen(
//       {super.key,
//       required this.email,
//       required this.password,
//       required this.user_name,
//       required this.login_as,
//       required this.reegitratrionid}) {
//     getAndSetLastDocumentData();
//   }

//   Future<void> getAndSetLastDocumentData() async {
//     try {
//       final documentReferencePatient = FirebaseFirestore.instance
//           .collection(reegitratrionid)
//           .doc(login_as)
//           .collection(user_name)
//           .doc(user_name);

//       final documentSnapshot = await documentReferencePatient.get();

//       if (documentSnapshot.exists) {
//         lastDocumentData = documentSnapshot.data() as Map<String, dynamic>;
//         // Access individual fields using lastDocumentData

//         String? email = lastDocumentData?['email'] as String?;
//         String? login_as = lastDocumentData?['loggin_as'] as String?;
//         String? password = lastDocumentData?['password'] as String?;
//         String? registration_id = lastDocumentData?['registration_id'] as String?;
//         String? user_name = lastDocumentData?['user_name'] as String?;

//         if (email != null) {
//           print('Email: $email');
//         }

//         if (login_as != null) {
//           print('Login As: $login_as');
//         }

//         if (password != null) {
//           print('Password: $password');
//         }

//         if (registration_id != null) {
//           print('Registration ID: $registration_id');
//         }

//         if (user_name != null) {
//           print('User Name: $user_name');
//         }

//         print('Data from the last document: $lastDocumentData');
//       } else {
//         print('Document does not exist.');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _logout(BuildContext context) async {
//     await _auth.signOut();

//     var sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => login_Screen()),
//     );
//   }

//   final db = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//         actions: <Widget>[
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               if (value == 'updateEmail') {
//                 // _updateEmail();
//               } else if (value == 'updatePassword') {
//                 // _updatePassword();
//               } else if (value == 'deleteAccount') {
//                 // _deleteAccount(context);
//               } else if (value == 'logout') {
//                 _logout(context);
//               }
//             },
//             itemBuilder: (BuildContext context) {
//               return [
//                 // PopupMenuItem<String>(
//                 //   value: 'updateEmail',
//                 //   child: Text('Update Email'),
//                 // ),
//                 // PopupMenuItem<String>(
//                 //   value: 'updatePassword',
//                 //   child: Text('Update Password'),
//                 // ),
//                 // PopupMenuItem<String>(
//                 //   value: 'deleteAccount',
//                 //   child: Text('Delete Account'),
//                 // ),
//                 PopupMenuItem<String>(
//                   value: 'logout',
//                   child: Text('Logout'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db.collection('User').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           // Data is available
//           final querySnapshot = snapshot.data!;
//           final userList = querySnapshot.docs;

//           return ListView.builder(
//             itemCount: userList.length,
//             itemBuilder: (context, index) {
//               final docSnapshot = userList[index];
//               final username = docSnapshot.id;
//               final email = docSnapshot
//                   .get('email'); // Change 'email' to your actual field name

//               return ListTile(
//                 title: Text(username),
//                 subtitle: Text(email),
//                 trailing: Icon(Icons.edit),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => UpdateUserDetails(),
//                     ),
//                   );
//                 },
//                 // You can add more properties to ListTile if needed
//                 // For example: trailing: Icon(Icons.chevron_right),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

//   //   db.collection("User").get().then(
//   //     (querySnapshot) {
//   //       print("Successfully completed");
//   //       for (var docSnapshot in querySnapshot.docs) {
//   //         print('${docSnapshot.id} => ${docSnapshot.data()}');
//   //       }
//   //     },
//   //     onError: (e) => print("Error completing: $e"),
//   //   );
//   // }





//       // ListView.separated(itemBuilder: (context, index){
//       //   return ListTile(
//       //     // leading: ,
//       //     title: ,
//       //     subtitle: ,
//       //     trailing: Icon(Icons.edit),
//       //   );
//       // },
//       // itemCount: 5,
//       // separatorBuilder: (context, index){
//       //   return Divider(height: 20, thickness: 1,);
//       // }
//       // ),
//     // );