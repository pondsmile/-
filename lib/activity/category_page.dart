import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:license_plate_recognition_app/activity/add_page.dart';
import 'package:license_plate_recognition_app/activity/user/personnel.dart';
import 'package:license_plate_recognition_app/activity/user/student.dart';
import 'package:license_plate_recognition_app/activity/user/teacher.dart';

import '../model/theme_text_style.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var onlyBuddhistYear = now.yearInBuddhistCalendar;

    var formatter = DateFormat.yMMMMEEEEd();
    var dateThai = formatter.formatInBuddhistCalendarThai(now);

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${dateThai}',
                        style: ThemeTextStyle.title(context))),
              ),
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(18, 4, 0, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'หมวดหมู่',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonnelPage()),
                  );
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.teal.shade200,
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'บุคลากร',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/personnel.png'),
                          )
                        ],
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TeacherPage()),
                  );
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.orange.shade200,
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'อาจารย์',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/teacher.png'),
                          )
                        ],
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentPage()),
                  );
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.purple.shade200,
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'นักศึกษา',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/students.png'),
                          )
                        ],
                      ),
                    )),
              ),
              // Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.0),
              //     ),
              //     color: Colors.pink.shade200,
              //     child: Container(
              //       height: 80,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           const Text(
              //             'อื่นๆ         ',
              //             style: TextStyle(
              //                 fontSize: 22,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //           ),
              //           Image.asset('assets/images/p1.png')
              //         ],
              //       ),
              //     ))
              // Padding(
              //   padding: const EdgeInsets.only(top: 50.0),
              //   child: Container(
              //     color: Colors.white,
              //     child: Center(
              //         child: Image.asset(
              //       'assets/images/car_1.gif',
              //       height: 250,
              //       width: 250,
              //     )),
              //   ),
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDatePage()),
          );
        },
        label: const Text(
          'เพิ่มข้อมูล',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
