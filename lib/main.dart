import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/add_product.dart';
import 'package:onlineshop/product_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCWXIHil2ZSmIY2Mf9k8R-T-ICttjzSPfI",
        authDomain: "eshop-aaf57.firebaseapp.com",
        databaseURL: "https://eshop-aaf57-default-rtdb.firebaseio.com",
        projectId: "eshop-aaf57",
        storageBucket: "eshop-aaf57.appspot.com",
        messagingSenderId: "178172248344",
        appId: "1:178172248344:web:2e97a3f9dc2b8151da5e6d",
        measurementId: "G-EY32CEG0ES"
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}
