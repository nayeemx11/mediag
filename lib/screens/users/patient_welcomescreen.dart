import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:file_picker/file_picker.dart';


import 'package:mediag/screens/authentication/login_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';


class Patient_WelcomeScreen extends StatefulWidget {
  @override
  _Patient_WelcomeScreenState createState() => _Patient_WelcomeScreenState();
}

class _Patient_WelcomeScreenState extends State<Patient_WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _selectedFile;
  String? _downloadURL;

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => login_Screen()),
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      User user = _auth.currentUser!;
      await user.delete();

      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => login_Screen()),
      );
        } catch (error) {
      // Handle error
    }
  }

  Future<void> _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          setState(() {
            _selectedFile = File(file.path!); // Use the non-null assertion operator (!)
          });
        } else {
          print('Error: File path is null.');
        }
      }
    } catch (e) {
      print('Error selecting file: $e');
    }
  }


  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      try {
        firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
        firebase_storage.Reference pdfRef = storage.ref().child('pdfs').child('file-to-upload.pdf');

        await pdfRef.putFile(_selectedFile!);

        // Optionally, get the download URL
        String downloadURL = await pdfRef.getDownloadURL();
        setState(() {
          _downloadURL = downloadURL;
        });

        print('PDF Download URL: $_downloadURL');
      } catch (e) {
        print('Error uploading PDF: $e');
      }
    }
  }

  Future<void> _downloadFile() async {
    try {
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference pdfRef = storage.ref().child('pdfs').child('file-to-upload.pdf');

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/downloaded-file.pdf';

      await pdfRef.writeToFile(File(filePath));

      setState(() {
        _downloadURL = filePath;
      });

      print('PDF Downloaded to: $_downloadURL');
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'deleteAccount') {
                _deleteAccount(context);
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'deleteAccount',
                  child: Text('Delete Account'),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(159, 255, 248, 101),
              const Color.fromRGBO(255, 133, 197, 235)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_selectedFile != null)
                Text('Selected File: ${_selectedFile!.path}'),
              ElevatedButton(
                onPressed: _selectFile,
                child: Text('Select PDF File'),
              ),
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Upload PDF'),
              ),
              if (_downloadURL != null)
                ElevatedButton(
                  onPressed: _downloadFile,
                  child: Text('Download PDF'),
                ),
              Text("This welcome login as a patient screen will be implemented soon"),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mediag/screens/authentication/login_screen.dart';
// import 'package:mediag/screens/splash/splash_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


// extension ObjectExtension on Object {
//   dynamic operator [](String key) {
//     if (this is Map<String, dynamic>) {
//       return (this as Map<String, dynamic>)[key];
//     }
//     return null;
//   }
// }

// class Patient_WelcomeScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _logout(BuildContext context) async {
//     await _auth.signOut();

//     var sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => login_Screen()),
//     );
//   }

//   // Future<void> _updateEmail() async {
//   //   // Implement your update email logic here
//   // }

//   // Future<void> _updatePassword() async {
//   //   // Implement your update password logic here
//   // }

//   Future<void> _deleteAccount(BuildContext context) async {
//     try {
//       User user = _auth.currentUser!;
//       // ignore: unnecessary_null_comparison
//       if (user != null) {
//         await user.delete();

//         var sharedPreferences = await SharedPreferences.getInstance();
//         sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => login_Screen()),
//         );
//       }
//     } catch (error) {
//       // Handle error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome'),
//         actions: <Widget>[
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               if (value == 'updateEmail') {
//                 // _updateEmail();
//               } else if (value == 'updatePassword') {
//                 // _updatePassword();
//               } else if (value == 'deleteAccount') {
//                 _deleteAccount(context);
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
//                 PopupMenuItem<String>(
//                   value: 'deleteAccount',
//                   child: Text('Delete Account'),
//                 ),
//                 PopupMenuItem<String>(
//                   value: 'logout',
//                   child: Text('Logout'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(159, 255, 248, 101),
//               const Color.fromRGBO(255, 133, 197, 235)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Text("this welcome login as patient screen will be implemented soon"),

//           // child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           // children: <Widget>[
//           // StreamBuilder<QuerySnapshot>(
//           //   stream:
//           //       FirebaseFirestore.instance.collection('Users').snapshots(),
//           //   builder: (context, snapshot) {
//           //     if (!snapshot.hasData) {
//           //       return CircularProgressIndicator();
//           //     }
//           //     final users = snapshot.data!.docs;
//           //     return SizedBox(
//           //       height: 500,
//           //       child: ListView.builder(
//           //         itemCount: users.length,
//           //         itemBuilder: (context, index) {
//           //           final user = users[index].data()!;
//           //           return ListTile(
//           //             title: Text(user['name']),
//           //             subtitle: Text(user['email']),
//           //           );
//           //         },
//           //       ),
//           //     );
//           //   },
//           // ),
//           // Text('Welcome to the App!'),
//           // SizedBox(height: 20),
//           // ElevatedButton(
//           //   onPressed: () => _logout(context),
//           //   child: Text('Logout'),
//           // ),
//           // ],
//           // ),
//         ),
//       ),
//     );
//   }
// }
