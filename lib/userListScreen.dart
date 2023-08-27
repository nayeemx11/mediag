import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediag/updateusersdetails.dart';

class UserListScreen extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('User').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Data is available
          final querySnapshot = snapshot.data!;
          final userList = querySnapshot.docs;

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final docSnapshot = userList[index];
              final username = docSnapshot.id;
              final email = docSnapshot
                  .get('email'); // Change 'email' to your actual field name

              return ListTile(
                title: Text(username),
                subtitle: Text(email),
                trailing: Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateUserDetails(),
                    ),
                  );
                },
                // You can add more properties to ListTile if needed
                // For example: trailing: Icon(Icons.chevron_right),
              );
            },
          );
        },
      ),
    );
  }
}

  //   db.collection("User").get().then(
  //     (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }





      // ListView.separated(itemBuilder: (context, index){
      //   return ListTile(
      //     // leading: ,
      //     title: ,
      //     subtitle: ,
      //     trailing: Icon(Icons.edit),
      //   );
      // },
      // itemCount: 5,
      // separatorBuilder: (context, index){
      //   return Divider(height: 20, thickness: 1,);
      // }
      // ),
    // );