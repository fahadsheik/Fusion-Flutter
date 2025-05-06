import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/request_guest_room_page.dart';
import 'pages/complaints_page.dart';
import 'pages/room_allotment_page.dart';
import 'pages/notice_board_page.dart';
import 'pages/my_fines_page.dart';
import 'pages/leaves_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    routes: {
      "/allottedRoom": (context) => RoomAllotmentPage(),
      "/guestRoom": (context) => GuestRoomRequestPage(),
      "/complaints": (context) => ComplaintsPage(),
      "/noticeBoard": (context) => NoticeBoardPage(),
      "/fines": (context) => MyFinesPage(),
      "/leaves": (context) => LeaveStatusPage(),
    },
  ));
}
