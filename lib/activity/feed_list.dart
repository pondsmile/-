import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:license_plate_recognition_app/activity/feed_list_in.dart';
import 'package:license_plate_recognition_app/activity/feed_list_out.dart';
import 'package:line_icons/line_icons.dart';

import '../model/theme_text_style.dart';

class FeeList extends StatefulWidget {
  const FeeList({Key? key}) : super(key: key);

  @override
  _FeeListState createState() => _FeeListState();
}

class _FeeListState extends State<FeeList> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var onlyBuddhistYear = now.yearInBuddhistCalendar;

    var formatter = DateFormat.yMMMMEEEEd();
    var dateThai = formatter.formatInBuddhistCalendarThai(now);

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
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
                                  'รายการ',
                                  style: TextStyle(
                                      color: Colors.teal,
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
                          const TabBar(
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.orange,
                            tabs: [
                              Tab(
                                  text: 'เข้า',
                                  icon: Icon(
                                    Icons.arrow_circle_down_rounded,
                                    color: Colors.teal,
                                    size: 32,
                                  )),
                              Tab(
                                  text: 'ออก',
                                  icon: Icon(
                                    Icons.arrow_circle_up_rounded,
                                    color: Colors.redAccent,
                                    size: 32,
                                  )),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ];
                },
                body: const TabBarView(
                  children: [FeedListIn(), FeedListOut()],
                ),
              ),
            ),
          )
          // Scaffold(
          //   backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          //   appBar: PreferredSize(
          //     preferredSize: Size.fromHeight(150.0),
          //     child: AppBar(
          //       systemOverlayStyle: const SystemUiOverlayStyle(
          //           statusBarColor: Colors.transparent,
          //           statusBarBrightness: Brightness.dark),
          //       bottom: const TabBar(
          //         labelColor: Colors.white,
          //         unselectedLabelColor: Colors.grey,
          //         indicatorColor: Colors.transparent,
          //         tabs: [
          //           Tab(
          //               text: 'เข้า',
          //               icon: Icon(
          //                 Icons.arrow_downward_outlined,
          //                 color: Colors.green,
          //                 size: 32,
          //               )),
          //           Tab(
          //               text: 'ออก',
          //               icon: Icon(
          //                 Icons.arrow_upward_outlined,
          //                 color: Colors.redAccent,
          //                 size: 32,
          //               )),
          //         ],
          //       ),
          //       elevation: 0,
          //       backgroundColor: Colors.black,
          //       centerTitle: false,
          //       title: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
          //             child: Align(
          //                 alignment: Alignment.centerLeft,
          //                 child: Text('${dateThai}',
          //                     style: ThemeTextStyle.title(context))),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
          //             child: Align(
          //               alignment: Alignment.centerLeft,
          //               child: Text(
          //                 'รายการ',
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 28,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   body: const TabBarView(
          //     children: [FeedListIn(), FeedListOut()],
          //   ),
          // ),

          ),
    );
  }
}
