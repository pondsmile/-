import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:license_plate_recognition_app/activity/user/list_user/item_list/list_item_user_in.dart';
import 'package:license_plate_recognition_app/activity/user/list_user/item_list/list_item_user_out.dart';

class ListUser extends StatefulWidget {
  final String licenses;
  final String province;
  final Color color;
  const ListUser(
      {Key? key,
      required this.licenses,
      required this.color,
      required this.province})
      : super(key: key);

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    tooltip: 'ย้อนกลับ',
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(top: 24),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: widget.licenses,
                          style: const TextStyle(fontSize: 36),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n' + widget.province,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.black,
                  height: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
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
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                            text: 'เข้า',
                            icon: Icon(
                              Icons.arrow_circle_down,
                              color: Colors.teal,
                              size: 28,
                            )),
                        Tab(
                            text: 'ออก',
                            icon: Icon(
                              Icons.arrow_circle_up,
                              color: Colors.redAccent,
                              size: 28,
                            )),
                      ],
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                ItemUserListIn(text: widget.licenses),
                ItemUserListOut(text: widget.licenses)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
