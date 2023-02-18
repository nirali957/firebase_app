import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                sendData();
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 45)),
              ),
              child: const Text("Send Data"),
            ),
          ],
        ),
      ),
    );
  }

  sendData() {
    CollectionReference users = firebaseFirestore.collection('users');

    //   return users
    //       .doc("1")
    //       .set({
    //         'full_name': "John Doe",
    //         'company': " Stokes and Sons",
    //         'age': 42,
    //         'work': [1, 2, 3, 4, 5],
    //       })
    //       .then((value) => debugPrint("User Added"))
    //       .catchError((error) => debugPrint("Failed to add user: $error"));

    return users
        .add({
          'full_name': "John Doe",
          'company': " Stokes and Sons",
          'age': 42,
          'work': [1, 2, 3, 4, 5],
        })
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }
}
