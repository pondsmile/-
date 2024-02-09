import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license_plate_recognition_app/activity/user/list_user/list_user.dart';
import 'package:line_icons/line_icons.dart';

import '../remove_alert_dialog.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final databaseRef = FirebaseDatabase.instance.reference().child('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade200,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: Colors.purple.shade200,
        centerTitle: true,
        title: Card(
          color: Colors.purple,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(18, 4, 18, 8),
            child: Text(
              'นักศึกษา',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: FirebaseAnimatedList(
        defaultChild: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'กำลังโหดข้อมูล',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        )),
        sort: (a, b) => b.value['นักศึกษา']
            .toString()
            .compareTo(a.value['นักศึกษา'].toString()),
        query: databaseRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return snapshot.value['status'] == 'นักศึกษา'
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListUser(
                                  licenses: snapshot.value['licenses'],
                                  province: snapshot.value['province'],
                                  color: Colors.purple.shade200,
                                )),
                      );
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.orange.shade50,
                        elevation: 0,
                        child: Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 0,
                                  color: Colors.orange.shade100,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/students.png',
                                        height: 80,
                                        width: 80,
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        updateDialog(
                                            snapshot.value['licenses'],
                                            snapshot.value['province'],
                                            snapshot.value['brand'],
                                            snapshot.value['model'],
                                            snapshot.value['name'],
                                            snapshot.value['number'],
                                            snapshot.value['status'],
                                            context,
                                            snapshot.key);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          barrierColor: Colors.black26,
                                          context: context,
                                          builder: (context) {
                                            return RemoveAlertDialog(
                                              title: "ลบข้อมูลป้ายทะเบียนรถ",
                                              description:
                                                  "ข้อมูลป้ายทะเบียนรถ จะถูกลบออกจากฐานข้อมูล และไม่สามารถกู้คืนได้",
                                              licenses_key: snapshot.key,
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.delete_outline,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 18),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      LineIcons.carSide,
                                                      color: Colors.orange,
                                                      size: 32.0,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors
                                                            .orange.shade100,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    'เลขทะเบียน : ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  Text(
                                                                    snapshot.value[
                                                                        'licenses'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    'จังหวัด : ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  Text(
                                                                    snapshot.value[
                                                                        'province'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    'ยี่ห้อ : ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  Text(
                                                                    snapshot.value[
                                                                        'brand'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    'รุ่น : ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  Text(
                                                                    snapshot.value[
                                                                        'model'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  color: Colors.amber,
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Icon(
                                                        LineIcons.portrait,
                                                        color: Colors.red,
                                                        size: 32.0,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Text(
                                                            'เจ้าของรถ : ',
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .value['name'],
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      width: 42,
                                                    ),
                                                    const Text(
                                                      'เบอร์ติดต่อ : ',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      snapshot.value['number'],
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade200,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.shade100,
                                    blurRadius: 4,
                                    offset: Offset(2, 2), // Shadow position
                                  ),
                                ], // green shaped
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.door_back_door_sharp,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    snapshot.value['status'],
                                    style: TextStyle(
                                        color: Colors.orange.shade800,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ])),
                  ),
                )
              : Container();
        },
      )),
    );
  }

  Future<void> updateDialog(
      String licenses,
      String province,
      String brand,
      String model,
      String name,
      String number,
      String status,
      BuildContext context,
      var key) {
    var licensesController = TextEditingController(text: licenses);
    var provinceController = TextEditingController(text: province);
    var brandController = TextEditingController(text: brand);
    var modelController = TextEditingController(text: model);
    var nameController = TextEditingController(text: name);
    var numberController = TextEditingController(text: number);
    var statusController = TextEditingController(text: status);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            backgroundColor: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    "แก้ไขข้อมูล",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      "เลขทะเบียน : $licenses",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  //const SizedBox(height: 15),
                  Center(
                    child: Text(
                      "จังหวัด : $province",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  //const SizedBox(height: 15),
                  Center(
                    child: Text(
                      "สถานะ : $status",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: TextFormField(
                      controller: brandController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "ยี่ห้อ :"),
                    )),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: TextFormField(
                      controller: modelController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(), labelText: "รุ่น :"),
                    )),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "เจ้าของรถ :"),
                    )),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "เบอร์ติดต่อ :"),
                    )),
                  ),
                  // const SizedBox(height: 15),

                  const SizedBox(height: 20),
                  const Divider(
                    height: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: InkWell(
                      highlightColor: Colors.grey[200],
                      onTap: () {
                        UpdateData(
                            licensesController.text,
                            provinceController.text,
                            brandController.text,
                            modelController.text,
                            nameController.text,
                            numberController.text,
                            statusController.text,
                            key);
                      },
                      child: const Center(
                        child: Text(
                          "ยืนยัน",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      highlightColor: Colors.grey[200],
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Center(
                        child: Text(
                          "ยกเลิก",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void UpdateData(String licenses, String province, String brand, String model,
      String name, String number, String status, var key) {
    Map<String, String> x = {
      "licenses": licenses,
      "province": province,
      "brand": brand,
      "model": model,
      "name": name,
      "number": number,
      "status": status,
    };
    print(licenses);
    FirebaseDatabase.instance
        .reference()
        .child('user/' + key!)
        .update(x)
        .then((value) {
      Navigator.of(context).pop();
    });
  }
}
