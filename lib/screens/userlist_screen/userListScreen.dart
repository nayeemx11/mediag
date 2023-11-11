import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediag/screens/updateuserdetails/updateusersdetails.dart';
import 'package:mediag/screens/updateuserdetails/userupdateprofileview.dart';

class UserListScreen extends StatefulWidget {
  final String _registrationid;

  const UserListScreen({super.key, required String registrationid})
      : _registrationid = registrationid;

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late List<dynamic> allData = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  CollectionReference get _collectionRef =>
      FirebaseFirestore.instance.collection(widget._registrationid);

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final data = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    setState(() {
      allData = data;
    });
  }

  Future<String> getPasskeyValue(int index) async {
    String collectionName = widget._registrationid;
    String documentName = allData[index]['email'];
    String fieldName = 'passkey';

    // Access Firestore and get the field value
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .get();

    // Check if the document exists and the field is not null
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      // Access the field value
      return documentSnapshot.get(fieldName).toString();
    } else {
      return 'Document or field not found';
    }
  }

  void _showVerificationPopup(String email, int index) {
    String enteredCode = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter 4-digit code for $email:'),
          content: TextField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            onChanged: (value) {
              enteredCode = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Check if enteredCode matches the expected code
                if ((enteredCode.toString()) ==
                    (await getPasskeyValue(index))) {
                  print(await getPasskeyValue(index));
                  Navigator.of(context).pop(); // Close the dialog
                  _navigateToNextScreen(email);
                } else {
                  print(await getPasskeyValue(index));
                  // Show an error or do something else
                  print('Incorrect code entered');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToNextScreen(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(email, widget._registrationid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: allData.length,
        itemBuilder: (BuildContext context, int index) {
          final userName = allData[index]['user_name'];
          final email = allData[index]['email'];

          if (userName != null && email != null) {
            return ListTile(
              title: Text(userName),
              subtitle: Text(email),
              onTap: () {
                _showVerificationPopup(email, index);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
