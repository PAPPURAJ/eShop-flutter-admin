import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlineshop/common_tools/widget/button.dart';

import 'common_tools.dart';

void deleteFireDialog(BuildContext context, DocumentReference reference,
    String storageURL, Function function) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Image(
                        image: AssetImage('assets/images/directory_icon.png')),
                  ),

                  // SizedBox(
                  //   height: 20,
                  // ),
                  //
                  // ButtonWidget(
                  //   text: 'Update',
                  //   icon: Icons.cloud_upload_outlined, onClicked: () {
                  //
                  // },
                  // ),
                  Space(20),
                  myRactanButton(context, "Delete", () {
                    reference.delete().whenComplete(() {
                      if (storageURL.isNotEmpty) {
                        FirebaseStorage.instance
                            .refFromURL(storageURL)
                            .delete()
                            .whenComplete(() {
                          Fluttertoast.showToast(msg: 'Deleted!');
                          function();
                          Navigator.pop(context);
                        });
                      } else {
                        Fluttertoast.showToast(msg: 'Deleted!');
                        function();
                        Navigator.pop(context);
                      }
                    });
                  }, 0.9, Colors.red),
                ],
              ),
            ),
          ));
}

void deleteAllRecords(String ID) {}
