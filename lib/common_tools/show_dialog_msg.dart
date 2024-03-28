import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlineshop/common_tools/widget/button_widget.dart';

import 'common_tools.dart';

void showDialogMsg(BuildContext context, String msg, Function function) {
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
                        image: AssetImage('assets/images/analyse_xray.png')),
                  ),
                  Space(5),
                  Center(
                      child: Text(
                    msg,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                  Space(20),
                  ButtonWidget(
                    text: 'Dismiss',
                    icon: Icons.clear,
                    onClicked: () {
                      function();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ));
}

void deleteAllRecords(String ID) {}
