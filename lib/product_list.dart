import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/add_product.dart';
import 'package:onlineshop/common_tools/common_tools.dart';
import 'package:onlineshop/common_tools/delete_feature.dart';

String? ID;
var PHOTOGRAPH_FIRE="Product";
var PHOTOGRAPH="Photograph";
class ProductMain extends StatefulWidget {

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductMain> {
  @override
  Widget build(BuildContext context) {
    var reference = FirebaseFirestore.instance.collection(PHOTOGRAPH_FIRE);

    //getData();
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPhotography()));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Space(40),
          const Text(
            "Products List",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Space(20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: StreamBuilder(
                stream: reference
                    .where('ID', isEqualTo: ID)
                    .orderBy('FileName', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(snapshot.data!.size, (index) {
                        // if (snapshot.data!.docs
                        //         .map((e) => e['ID'])
                        //         .elementAt(index) !=
                        //     ID) return Container();

                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ViewPhoto(
                            //             snapshot.data!.docs
                            //                 .map((e) => e['URL'])
                            //                 .elementAt(index),
                            //             snapshot.data!.docs
                            //                     .map((e) => e['Time'])
                            //                     .elementAt(index) +
                            //                 "  " +
                            //                 snapshot.data!.docs
                            //                     .map((e) => e['Date'])
                            //                     .elementAt(index))));
                          },
                          onLongPress: () {
                            deleteFireDialog(
                                context,
                                snapshot.data!.docs.elementAt(index).reference,
                                snapshot.data!.docs
                                    .map((e) => e['URL'])
                                    .elementAt(index),
                                () {});
                          },
                          child: Hero(
                              tag: snapshot.data!.docs
                                  .map((e) => e['URL'])
                                  .elementAt(index),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.green,
                                        style: BorderStyle.solid,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.docs
                                            .map((e) => e["URL"])
                                            .elementAt(index)
                                            .toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Text('Price: '+
                                      snapshot.data!.docs
                                              .map((e) => e['Price'])
                                              .elementAt(index),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.green,
                                        //backgroundColor: Color.fromRGBO(255, 255, 255, 150)
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 25,
                                    right: 10,
                                    child: Text(
                                      snapshot.data!.docs
                                          .map((e) => e['Name'])
                                          .elementAt(index),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        );
                      }),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> getData() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(PHOTOGRAPH_FIRE)
        .where('ID < \'100\'')
        .get();
    print('=============== ${snap.size}');
  }
}
