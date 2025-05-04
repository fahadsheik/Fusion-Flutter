// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:async'; 
import 'bottom_bar.dart'; 
import 'sidebar.dart'; 
import 'gesture_sidebar.dart'; 

class SearchScreen extends StatefulWidget {
  final bool autoFocusSearch;

  const SearchScreen({super.key, this.autoFocusSearch = false});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  

  Widget _buildNoResultsFound() {
    return Scaffold(
    PlaceHolder;
    );
  }
}

class ModuleItem {
  final String name;
  final IconData icon;
  final Color color;
  final WidgetBuilder route;

  ModuleItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class SubModuleItem {
  final String name;
  final IconData icon;
  final Color color;
  final WidgetBuilder route;
  final String parentModule;
  final String description;

  SubModuleItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.route,
    required this.parentModule,
    required this.description,
  });
}
