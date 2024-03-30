import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlineshop/common_tools/common_tools.dart';
import 'package:onlineshop/common_tools/date_time.dart';
import 'package:onlineshop/common_tools/firebase_api.dart';
import 'package:onlineshop/common_tools/widget/button_widget.dart';

File? imageFile;
var _ID;
var PHOTOGRAPH_FIRE="Product";
var PHOTOGRAPH="Photograph";
TextEditingController nameCont = TextEditingController();
TextEditingController priceCont = TextEditingController();
BuildContext? cnxt;

class AddPhotographyMain extends StatelessWidget {
  AddPhotographyMain(var ID) {
    _ID = ID;
  }

  @override
  Widget build(BuildContext context) => AddPhotography();
}

class AddPhotography extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<AddPhotography> {
  UploadTask? task;
  File? file;

  final imgPicker = ImagePicker();
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () async {
                      var imgCamera =
                      await imgPicker.getImage(source: ImageSource.camera);
                      setState(() {
                        file = File(imgCamera!.path);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () async {
                      var imgGallery =
                      await imgPicker.getImage(source: ImageSource.gallery);
                      setState(() {
                        file = File(imgGallery!.path);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    cnxt = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => showOptionsDialog(context),
                  child: Container(
                    child: file != null
                        ? Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(file!),
                          )),
                    )
                        : Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                      child: const Image(
                          image: AssetImage(
                              'assets/selectimage.png')),
                    ),
                  ),
                ),
                Space(48),
                TextField(
                  controller: nameCont,
                  decoration: const InputDecoration(
                      hintText: "Enter name"
                  ),
                ),
                Space(48),
                TextField(
                  controller: priceCont,
                  decoration: const InputDecoration(
                    hintText: "Enter price"
                  ),

                ),
                Space(48),
                ButtonWidget(
                  text: 'Upload product',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: () {
                    uploadFile();
                  },
                ),
                Space(20),
                task != null ? buildUploadStatus(task!) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadFile() async {
    String fileName = getDateTimeString();
    if (file == null) {
      Fluttertoast.showToast(msg: "Please select a picture");
      return;
    }

    final destination = PHOTOGRAPH_FIRE + '/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    Map<String, Object> data = HashMap();
    data["URL"] = urlDownload;
    data["Name"] = nameCont.text.isEmpty ? getDateTimeName() : nameCont.text;
    data["FileName"] = fileName;
    data["Date"] = getDate();
    data['Time'] = getTime();
    data['Price']=priceCont.text.isEmpty ? "0.00" : priceCont.text;

    FirebaseFirestore.instance
        .collection(PHOTOGRAPH_FIRE)
        .add(data)
        .whenComplete(() => {
      Fluttertoast.showToast(msg: "Data added"),
      Navigator.pop(context),
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}