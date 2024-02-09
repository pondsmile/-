// ignore: import_of_legacy_library_into_null_safe
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:license_plate_recognition_app/activity/category_page.dart';
import 'package:license_plate_recognition_app/activity/feed_list.dart';
import 'package:license_plate_recognition_app/activity/search_page.dart';
import 'package:line_icons/line_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final page = [const FeeList(), const SearchPage(), const CategoryPage()];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
        body: page[_selectedIndex],
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 22,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[200]!,
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: LineIcons.stream,
                      text: 'รายการ',
                      iconColor: Colors.teal,
                      iconActiveColor: Colors.teal,
                      textColor: Colors.teal,
                    ),
                    GButton(
                      icon: LineIcons.search,
                      text: 'ค้นหา',
                      iconColor: Colors.orange,
                      iconActiveColor: Colors.orange,
                      textColor: Colors.orange,
                    ),
                    GButton(
                        icon: LineIcons.list,
                        text: 'หมวดหมู่',
                        iconColor: Colors.blue,
                        iconActiveColor: Colors.blue,
                        textColor: Colors.blue),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
              // FFNavigationBar(
              //   theme: FFNavigationBarTheme(
              //     selectedItemBorderColor: Colors.transparent,
              //     selectedItemBackgroundColor: Colors.orange,
              //     selectedItemIconColor: Colors.white,
              //     selectedItemLabelColor: Colors.black87,
              //     showSelectedItemShadow: false,
              //     barHeight: 70,
              //   ),
              //   selectedIndex: selectedIndex,
              //   onSelectTab: (index) {
              //     setState(() {
              //       selectedIndex = index;
              //     });
              //   },
              //   items: [
              //     FFNavigationBarItem(
              //       iconData: Icons.list_rounded,
              //       label: 'รายการ',
              //     ),
              //     FFNavigationBarItem(
              //       iconData: Icons.search_rounded,
              //       label: 'ค้นหาเลขทะเบียน',
              //       selectedBackgroundColor: Colors.purple,
              //     ),
              //     FFNavigationBarItem(
              //       iconData: Icons.category_rounded,
              //       label: 'หมวดหมู่',
              //       selectedBackgroundColor: Colors.red,
              //     ),
              //   ],
              // ),
            )));
  }
}
