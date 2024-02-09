import 'dart:async';

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:license_plate_recognition_app/activity/user/list_user/list_user.dart';
import 'package:license_plate_recognition_app/model/data.dart';
import 'package:line_icons/line_icons.dart';

import '../model/theme_text_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Data> dataList = [];
  bool searchState = false;

  @override
  void initState() {
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child('user');
    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        // ignore: unused_local_variable, unnecessary_new
        Data data = new Data(
            values[key]['licenses'],
            values[key]['province'],
            values[key]['brand'],
            values[key]['model'],
            values[key]['name'],
            values[key]['number'],
            values[key]['status'],
            key);
        dataList.add(data);
      }
      Timer(const Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var onlyBuddhistYear = now.yearInBuddhistCalendar;

    var formatter = intl.DateFormat.yMMMMEEEEd();
    var dateThai = formatter.formatInBuddhistCalendarThai(now);

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                bottom: const PreferredSize(
                  // Add this code
                  preferredSize: Size.fromHeight(30.0), // Add this code
                  child: Text(''), // Add this code
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 22, 0, 0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('${dateThai}',
                                style: ThemeTextStyle.title(context))),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ค้นหา',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    PreferredSize(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: TextField(
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.grey),
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'ค้นหาเลขทะเบียน หรือ ชื่อ',
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                              onChanged: (text) {
                                SearchMethod(text);
                              },
                            )),
                      ),
                      preferredSize: Size.fromHeight(150.0),
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: dataList.length == 0
              ? Container(
                  color: Colors.white,
                  child: Center(
                      child: Image.asset(
                    'assets/images/loading.gif',
                    height: 100,
                    width: 100,
                  )),
                )
              : RefreshIndicator(
                  color: Colors.black,
                  onRefresh: _pullRefresh,
                  child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (_, index) {
                        return CardUI(
                            dataList[index].licenses,
                            dataList[index].province,
                            dataList[index].brand,
                            dataList[index].model,
                            dataList[index].name,
                            dataList[index].number,
                            dataList[index].status);
                      }),
                ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void SearchMethod(String text) {
    DatabaseReference searchRef =
        FirebaseDatabase.instance.reference().child('user');
    searchRef.once().then((DataSnapshot snapShot) {
      dataList.clear();
      var keys = snapShot.value.keys;
      var values = snapShot.value;

      for (var key in keys) {
        // ignore: unused_local_variable, unnecessary_new
        Data data = new Data(
            values[key]['licenses'],
            values[key]['province'],
            values[key]['brand'],
            values[key]['model'],
            values[key]['name'],
            values[key]['number'],
            values[key]['status'],
            key);
        if (data.licenses.contains(text)) {
          dataList.add(data);
        } else if (data.name.contains(text)) {
          dataList.add(data);
        }
      }
      Timer(const Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }

  // ignore: non_constant_identifier_names
  Widget CardUI(String licenses, String province, String brand, String model,
      String name, String number, String status) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListUser(
                    licenses: licenses,
                    province: province,
                    color: Colors.purple.shade200,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(1.5),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
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
                              child: status == 'นักศึกษา'
                                  ? Image.asset(
                                      'assets/images/students.png',
                                      height: 80,
                                      width: 80,
                                    )
                                  : status == 'อาจารย์'
                                      ? Image.asset(
                                          'assets/images/teacher.png',
                                          height: 80,
                                          width: 80,
                                        )
                                      : Image.asset(
                                          'assets/images/personnel.png',
                                          height: 80,
                                          width: 80,
                                        )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                //print(licenses);

                                updateDialog(licenses, province, brand, model,
                                    name, number, status, context, licenses);
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
                                    return RemoveAlertDialogSearchs(
                                      title: "ลบข้อมูลป้ายทะเบียนรถ",
                                      description:
                                          "ข้อมูลป้ายทะเบียนรถ จะถูกลบออกจากฐานข้อมูล และไม่สามารถกู้คืนได้",
                                      licenses_key: licenses,
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
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
                                                    BorderRadius.circular(10),
                                                color: Colors.orange.shade100,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            licenses,
                                                            style:
                                                                const TextStyle(
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
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            province,
                                                            style:
                                                                const TextStyle(
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
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            brand,
                                                            style:
                                                                const TextStyle(
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
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            model,
                                                            style:
                                                                const TextStyle(
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
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: Icon(
                                                LineIcons.portrait,
                                                color: Colors.red,
                                                size: 32.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    'เจ้าของรถ : ',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Text(
                                                    name,
                                                    style: const TextStyle(
                                                        fontSize: 16),
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
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              number,
                                              style:
                                                  const TextStyle(fontSize: 16),
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
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.only(
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
                          Icon(
                            Icons.door_back_door_sharp,
                            color: Colors.orange,
                          ),
                          Text(
                            status,
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
          ],
        ),
      ),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(18.0),
                  //   child: Center(
                  //       child: TextFormField(
                  //     controller: statusController,
                  //     decoration: InputDecoration(
                  //         border: UnderlineInputBorder(), labelText: "สถานะ :"),
                  //   )),
                  // ),
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
    print(key);
    FirebaseDatabase.instance
        .reference()
        .child('user/' + key!)
        .update(x)
        .then((value) {
      _pullRefresh();
      Navigator.of(context).pop();
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      dataList.clear();
    });

    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child('user');
    referenceData.once().then((DataSnapshot dataSnapshot) {
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        // ignore: unused_local_variable, unnecessary_new
        Data data = new Data(
            values[key]['licenses'],
            values[key]['province'],
            values[key]['brand'],
            values[key]['model'],
            values[key]['name'],
            values[key]['number'],
            values[key]['status'],
            key);
        dataList.add(data);
      }
      Timer(const Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }

  Widget RemoveAlertDialogSearchs(
      {required String title,
      required String description,
      required String licenses_key}) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            "$title",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text(
                "$description",
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
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
                FirebaseDatabase.instance
                    .reference()
                    .child('user/' + licenses_key)
                    .remove()
                    .then((_) {
                  _pullRefresh();
                  Navigator.of(context).pop();
                });
              },
              child: const Center(
                child: Text(
                  "ลบ",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
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
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
