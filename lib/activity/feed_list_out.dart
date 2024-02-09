import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'user/list_user/list_feed_user.dart';

class FeedListOut extends StatefulWidget {
  const FeedListOut({Key? key}) : super(key: key);

  @override
  _FeedListOutState createState() => _FeedListOutState();
}

class _FeedListOutState extends State<FeedListOut> {
  final databaseRef =
      FirebaseDatabase.instance.reference().child('license/out');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: FirebaseAnimatedList(
        defaultChild: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Sloading.gif',
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'กำลังโหดข้อมูล',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              )
            ],
          )),
        ),
        sort: (a, b) => b.value['วันเวลาที่ตรวจพบ']
            .toString()
            .compareTo(a.value['วันเวลาที่ตรวจพบ'].toString()),
        query: databaseRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListFeed(
                          licenses: snapshot.value['license_plates_number'],
                        )),
              );
            }),
            child: Container(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.red.shade50,
                      elevation: 2,
                      child: Stack(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          LineIcons.carSide,
                                          color: Colors.orange,
                                          size: 32.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'เลขทะเบียน : ',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              snapshot.value[
                                                  'license_plates_number'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          LineIcons.calendar,
                                          color: Colors.red,
                                          size: 32.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'วันที่ตรวจพบ : ',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                snapshot
                                                    .value['วันเวลาที่ตรวจพบ'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.grey.shade600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 0,
                                color: Colors.red.shade700,
                                child: SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.value['เวลาที่ตรวจพบ'],
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // child: ListTile(
                          //   title: Padding(
                          //     padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          //     child: Row(
                          //       children: [
                          //         const Text(
                          //           'เลขทะเบียน : ',
                          //           style: TextStyle(fontSize: 18),
                          //         ),
                          //         Text(
                          //           snapshot.value['license_plates_number'],
                          //           style: const TextStyle(fontSize: 18),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Text(
                          //         'วัน/เวลาที่ตรวจพบ : ',
                          //         style: TextStyle(fontSize: 16),
                          //       ),
                          //       Text(
                          //         snapshot.value['เวลาที่ตรวจพบ'],
                          //         style: const TextStyle(fontSize: 16),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.red.shade200,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.shade100,
                                  blurRadius: 4,
                                  offset: Offset(2, 2), // Shadow position
                                ),
                              ], // green shaped
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.door_back_door_sharp,
                                  color: Colors.red.shade800,
                                ),
                                Text(
                                  "ตรวจจับทางออก",
                                  style: TextStyle(
                                      color: Colors.red.shade800,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
