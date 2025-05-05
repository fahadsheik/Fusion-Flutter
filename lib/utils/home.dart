// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'sidebar.dart';
import 'gesture_sidebar.dart';
import 'bottom_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final List<String> _searchHistory = [];
  final int _maxSearchHistory = 10;
  String _searchQuery = '';

  late AnimationController _searchAnimationController;
  late Animation<double> _searchAnimation;

  final FocusNode _searchFocusNode = FocusNode();

  String? _selectedModule;
  String? _selectedDateFilter;
  String? _selectedReadFilter;

  final List<String> _dateFilterOptions = [
    'All',
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    'This Year',
  ];

  final List<String> _readFilterOptions = [
    'All',
    'Read',
    'Unread',
  ];

  final List<Map<String, dynamic>> _announcements = [
    {
      'title': 'End Semester Examination Schedule',
      'module': 'Examination',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'content':
          'The End Semester Examination for all courses will commence from 15th May, 2025. Detailed schedule has been uploaded on the examination portal. Students are requested to check their respective schedules.',
      'author': 'Examination Controller',
      'priority': 'High',
      'isUnread': true,
      'hasAttachment': true,
      'attachmentName': 'exam_schedule_2025.pdf',
    },
    {
      'title': 'Library Membership Renewal',
      'module': 'Library',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'content':
          'All students and faculty members are requested to renew their library membership for the academic year 2025-2026. The renewal process starts from 1st April and ends on 15th April.',
      'author': 'Chief Librarian',
      'priority': 'Medium',
      'isUnread': true,
      'hasAttachment': false,
      'attachmentName': '',
    },
    {
      'title': 'Hostel Maintenance Notice',
      'module': 'Hostel',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'content':
          'Maintenance work will be carried out in Hostel Blocks A and B from 10th April to 15th April. Students are requested to cooperate with the maintenance staff.',
      'author': 'Hostel Warden',
      'priority': 'Medium',
      'isUnread': false,
      'hasAttachment': true,
      'attachmentName': 'maintenance_schedule.docx',
    },
    {
      'title':
          'Campus Placement Drive for Tech Solutions Inc. and Multiple Other Partner Companies',
      'module': 'Placement',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'content':
          'A campus placement drive for final year students will be conducted by Tech Solutions Inc. on 20th April. Eligible students should register on the placement portal by 15th April.',
      'author': 'Placement Officer',
      'priority': 'High',
      'isUnread': true,
      'hasAttachment': true,
      'attachmentName': 'eligibility_criteria.pdf',
    },
    {
      'title': 'Research Grant Applications',
      'module': 'Research',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'content':
          'Applications are invited for research grants under the Institute Innovation Scheme. Last date for submission is 30th April. Detailed guidelines are available on the research portal.',
      'author': 'Research Dean',
      'priority': 'Medium',
      'isUnread': false,
      'hasAttachment': true,
      'attachmentName': 'grant_guidelines.pdf',
    },
    {
      'title': 'New Course Introduction',
      'module': 'Academic',
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'content':
          'A new elective course on "Artificial Intelligence for Healthcare" will be offered from the next semester. Interested students can pre-register on the academic portal.',
      'author': 'Academic Dean',
      'priority': 'Low',
      'isUnread': false,
      'hasAttachment': false,
      'attachmentName': '',
    },
    {
      'title': 'Faculty Development Program',
      'module': 'HR',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'content':
          'A Faculty Development Program on "Effective Teaching Methodologies" will be conducted from 5th to 10th May. Faculty members are encouraged to participate.',
      'author': 'HR Manager',
      'priority': 'Medium',
      'isUnread': true,
      'hasAttachment': true,
      'attachmentName': 'schedule_and_registration.pdf',
    },
    {
      'title': 'Annual Cultural Fest',
      'module': 'Event',
      'date': DateTime.now().subtract(const Duration(days: 12)),
      'content':
          'The Annual Cultural Fest "Fusion 2023" will be held from 25th to 27th April. Student coordinators are requested to attend the planning meeting on 15th April.',
      'author': 'Cultural Secretary',
      'priority': 'High',
      'isUnread': false,
      'hasAttachment': true,
      'attachmentName': 'event_schedule.xlsx',
    },
    {
      'title': 'Budget Proposal Submission',
      'module': 'Finance',
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'content':
          'All departments are requested to submit their budget proposals for the financial year 2025-2026 by 20th April. The template for submission is available on the finance portal.',
      'author': 'Finance Officer',
      'priority': 'Medium',
      'isUnread': false,
      'hasAttachment': true,
      'attachmentName': 'budget_template.xlsx',
    },
    {
      'title': 'Patent Filing Workshop',
      'module': 'Patent',
      'date': DateTime.now().subtract(const Duration(days: 8)),
      'content':
          'A workshop on "Patent Filing Process and Guidelines" will be conducted on 18th April. Faculty members and research scholars are encouraged to attend.',
      'author': 'Patent Cell Coordinator',
      'priority': 'Low',
      'isUnread': true,
      'hasAttachment': true,
      'attachmentName': 'workshop_details.pdf',
    },
  ];

  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'System Maintenance Scheduled',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(hours: 1)),
      'content':
          'The system will be unavailable for maintenance on Sunday, April 15, 2025 from 2:00 AM to 6:00 AM.',
      'priority': 'High',
      'isUnread': true,
    },
    {
      'title': 'Password Reset Required',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'content':
          'For security reasons, please reset your password within the next 7 days.',
      'priority': 'Medium',
      'isUnread': true,
    },
    {
      'title': 'New Version Available',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(hours: 12)),
      'content':
          'A new version of Fusion App (v2.3.0) is now available. Please update your application for the latest features and security improvements.',
      'priority': 'Low',
      'isUnread': false,
    },
    {
      'title': 'Account Login Alert',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'content':
          'Your account was accessed from a new device. If this wasn\'t you, please contact the IT department immediately.',
      'priority': 'High',
      'isUnread': true,
    },
    {
      'title': 'Data Backup Complete',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'content':
          'Your account data has been successfully backed up to secure cloud storage.',
      'priority': 'Low',
      'isUnread': false,
    },
    {
      'title': 'System Update Successful',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'content':
          'The recent system update was successfully installed. All services are now running on the latest version.',
      'priority': 'Medium',
      'isUnread': true,
    },
    {
      'title': 'Account Verification',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'content':
          'Your account has been successfully verified. You now have access to all features of the Fusion App.',
      'priority': 'Medium',
      'isUnread': false,
    },
    {
      'title': 'Privacy Policy Update',
      'type': 'system',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'content':
          'Our privacy policy has been updated. Please review the changes and acknowledge your acceptance.',
      'priority': 'High',
      'isUnread': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedDateFilter = 'All';
    _selectedReadFilter = 'All';
    _searchController.addListener(_onSearchChanged);

    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _searchAnimation = CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    _searchAnimationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        _searchFocusNode.unfocus();
        _searchAnimationController.reverse();
      } else {
        _searchFocusNode.requestFocus();
        _searchQuery = '';
        _searchAnimationController.forward();
      }
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  void _addToSearchHistory(String query) {
    if (query.isEmpty) return;

    setState(() {
      _searchHistory.remove(query);
      _searchHistory.insert(0, query);
      if (_searchHistory.length > _maxSearchHistory) {
        _searchHistory.removeLast();
      }
    });
  }

  Widget _highlightSearchText(String text,
      {int maxLines = 1,
      bool isBold = false,
      double fontSize = 14.0,
      bool isRead = false}) {
    final Color textColor =
        isRead ? Colors.grey.shade600 : Colors.grey.shade900;

    if (_searchQuery.isEmpty) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
          color: textColor,
          height: 1.3,
        ),
      );
    }

    final pattern = RegExp(_searchQuery, caseSensitive: false);
    final matches = pattern.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
          color: textColor,
          height: 1.3,
        ),
      );
    }

    final List<TextSpan> children = [];
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        children.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            color: textColor,
          ),
        ));
      }

      children.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.blue.shade800,
          backgroundColor: Colors.blue.shade50,
        ),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      children.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
          color: textColor,
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: children),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  List<String> _getUniqueModules() {
    final Set<String> modules = {};

    for (final notification in _notifications) {
      final module = notification['module'] as String?;
      if (module != null) {
        modules.add(module);
      }
    }

    for (final announcement in _announcements) {
      final module = announcement['module'] as String?;
      if (module != null) {
        modules.add(module);
      }
    }

    final List<String> modulesList = modules.toList();
    modulesList.sort();
    return ['All'] + modulesList;
  }

  List<Map<String, dynamic>> _getFilteredAnnouncements() {
    List<Map<String, dynamic>> filtered = _announcements;

    if (_searchController.text.isNotEmpty) {
      filtered = filtered
          .where((announcement) =>
              (announcement['title'] != null &&
                  (announcement['title'] as String)
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())) ||
              (announcement['content'] != null &&
                  (announcement['content'] as String)
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())) ||
              (announcement['module'] != null &&
                  (announcement['module'] as String)
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())))
          .toList();
    }

    if (_selectedModule != null && _selectedModule != 'All') {
      filtered = filtered
          .where((announcement) => announcement['module'] == _selectedModule)
          .toList();
    }

    if (_selectedDateFilter != null && _selectedDateFilter != 'All') {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      filtered = filtered.where((announcement) {
        final date = announcement['date'] as DateTime?;

        if (date == null) return false;

        switch (_selectedDateFilter) {
          case 'Today':
            final announcementDate = DateTime(date.year, date.month, date.day);
            return announcementDate.isAtSameMomentAs(today);
          case 'Yesterday':
            final yesterday = today.subtract(const Duration(days: 1));
            final announcementDate = DateTime(date.year, date.month, date.day);
            return announcementDate.isAtSameMomentAs(yesterday);
          case 'This Week':
            final startOfWeek =
                today.subtract(Duration(days: today.weekday - 1));
            return date.isAfter(startOfWeek.subtract(const Duration(days: 1)));
          case 'This Month':
            return date.month == today.month && date.year == today.year;
          case 'This Year':
            return date.year == today.year;
          default:
            return true;
        }
      }).toList();
    }

    if (_selectedReadFilter != null && _selectedReadFilter != 'All') {
      filtered = filtered.where((announcement) {
        final isUnread = announcement['isUnread'] as bool? ?? false;

        switch (_selectedReadFilter) {
          case 'Read':
            return !isUnread;
          case 'Unread':
            return isUnread;
          default:
            return true;
        }
      }).toList();
    }

    filtered.sort((a, b) {
      final dateA = a['date'] as DateTime;
      final dateB = b['date'] as DateTime;
      return dateB.compareTo(dateA);
    });

    return filtered;
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    List<Map<String, dynamic>> filtered = _notifications;

    if (_searchController.text.isNotEmpty) {
      filtered = filtered
          .where((notification) =>
              (notification['title'] != null &&
                  (notification['title'] as String)
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())) ||
              (notification['content'] != null &&
                  (notification['content'] as String)
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())) ||
              (notification['module'] != null &&
                  (notification['module'] as String)
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())))
          .toList();
    }

    if (_selectedModule != null && _selectedModule != 'All') {
      filtered = filtered
          .where((notification) => notification['module'] == _selectedModule)
          .toList();
    }

    if (_selectedDateFilter != null && _selectedDateFilter != 'All') {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      filtered = filtered.where((notification) {
        final date = notification['date'] as DateTime?;

        if (date == null) return false;

        switch (_selectedDateFilter) {
          case 'Today':
            final notificationDate = DateTime(date.year, date.month, date.day);
            return notificationDate.isAtSameMomentAs(today);
          case 'Yesterday':
            final yesterday = today.subtract(const Duration(days: 1));
            final notificationDate = DateTime(date.year, date.month, date.day);
            return notificationDate.isAtSameMomentAs(yesterday);
          case 'This Week':
            final startOfWeek =
                today.subtract(Duration(days: today.weekday - 1));
            return date.isAfter(startOfWeek.subtract(const Duration(days: 1)));
          case 'This Month':
            return date.month == today.month && date.year == today.year;
          case 'This Year':
            return date.year == today.year;
          default:
            return true;
        }
      }).toList();
    }

    if (_selectedReadFilter != null && _selectedReadFilter != 'All') {
      filtered = filtered.where((notification) {
        final isUnread = notification['isUnread'] as bool? ?? false;

        switch (_selectedReadFilter) {
          case 'Read':
            return !isUnread;
          case 'Unread':
            return isUnread;
          default:
            return true;
        }
      }).toList();
    }

    filtered.sort((a, b) {
      final dateA = a['date'] as DateTime;
      final dateB = b['date'] as DateTime;
      return dateB.compareTo(dateA);
    });

    return filtered;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    final isSystemNotification = notification['type'] == 'system';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
      ),
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSystemNotification
                                    ? Colors.blue.shade50
                                    : Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSystemNotification
                                      ? Colors.blue.shade200
                                      : Colors.indigo.shade200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isSystemNotification
                                        ? HugeIcons.strokeRoundedSystemUpdate01
                                        : _getModuleTypeIcon(
                                            notification['module'] ?? ''),
                                    size: 16,
                                    color: isSystemNotification
                                        ? Colors.blue.shade700
                                        : Colors.indigo.shade700,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isSystemNotification
                                        ? 'System'
                                        : notification['module'] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isSystemNotification
                                          ? Colors.blue.shade700
                                          : Colors.indigo.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _formatDate(notification['date']),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                        child: Hero(
                          tag: 'notification_${notification['title']}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              notification['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['content'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showAnnouncementDetails(Map<String, dynamic> announcement) {
    final hasAttachment = announcement['hasAttachment'] as bool? ?? false;
    final attachmentName = announcement['attachmentName'] as String? ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
      ),
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: Colors.indigo.shade200),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _getModuleTypeIcon(announcement['module']),
                                    size: 16,
                                    color: Colors.indigo.shade700,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    announcement['module'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.indigo.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _formatDate(announcement['date']),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                        child: Hero(
                          tag: 'announcement_${announcement['title']}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              announcement['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcement['content'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                  height: 1.5,
                                ),
                              ),
                              if (hasAttachment) ...[
                                const SizedBox(height: 24),
                                TweenAnimationBuilder(
                                  duration: const Duration(milliseconds: 500),
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  builder: (context, double value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: Transform(
                                        transform: Matrix4.translationValues(
                                            0, 20 * (1 - value), 0),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.blue.shade100),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _getFileIcon(attachmentName),
                                          color: Colors.blue.shade700,
                                          size: 32,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                attachmentName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue.shade900,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                'Tap to download',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            HugeIcons.strokeRoundedDownload02,
                                            color: Colors.blue.shade700,
                                          ),
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    Text(
                                                        'Downloading $attachmentName...'),
                                                  ],
                                                ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showFilterOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(HugeIcons.strokeRoundedFilterEdit,
                            color: Colors.blue.shade800),
                        const SizedBox(width: 10),
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            setModalState(() {
                              _selectedModule = 'All';
                              _selectedDateFilter = 'All';
                              _selectedReadFilter = 'All';
                            });
                          },
                          icon: Icon(HugeIcons.strokeRoundedRefresh,
                              size: 18, color: Colors.red.shade600),
                          label: Text(
                            'Reset Filters',
                            style: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedMailValidation02,
                            size: 18,
                            color: Colors.grey.shade800,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _readFilterOptions.map((readOption) {
                        return ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                readOption == 'Read'
                                    ? Icons.visibility
                                    : readOption == 'Unread'
                                        ? HugeIcons.strokeRoundedViewOffSlash
                                        : Icons.remove_red_eye,
                                size: 16,
                                color: _selectedReadFilter == readOption
                                    ? Colors.blue.shade800
                                    : Colors.grey.shade700,
                              ),
                              const SizedBox(width: 6),
                              Text(readOption),
                            ],
                          ),
                          selected: _selectedReadFilter == readOption,
                          selectedColor: Colors.blue.shade100,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            fontWeight: _selectedReadFilter == readOption
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedReadFilter == readOption
                                ? Colors.blue.shade800
                                : Colors.grey.shade800,
                          ),
                          onSelected: (selected) {
                            setModalState(() {
                              _selectedReadFilter =
                                  selected ? readOption : 'All';
                            });
                          },
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedViewOffSlash,
                            size: 18,
                            color: Colors.grey.shade800,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Module',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _getUniqueModules().map((module) {
                        return ChoiceChip(
                          label: Text(module),
                          selected: _selectedModule == module,
                          selectedColor: Colors.blue.shade100,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            fontWeight: _selectedModule == module
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedModule == module
                                ? Colors.blue.shade800
                                : Colors.grey.shade800,
                          ),
                          onSelected: (selected) {
                            setModalState(() {
                              _selectedModule = selected ? module : 'All';
                            });
                          },
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedCalendar03,
                            size: 18,
                            color: Colors.grey.shade800,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _dateFilterOptions.map((dateOption) {
                        return ChoiceChip(
                          label: Text(dateOption),
                          selected: _selectedDateFilter == dateOption,
                          selectedColor: Colors.blue.shade100,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            fontWeight: _selectedDateFilter == dateOption
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedDateFilter == dateOption
                                ? Colors.blue.shade800
                                : Colors.grey.shade800,
                          ),
                          onSelected: (selected) {
                            setModalState(() {
                              _selectedDateFilter =
                                  selected ? dateOption : 'All';
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24.0),
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 0.95, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                });
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Apply Filters',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasActiveFilters =
        (_selectedModule != null && _selectedModule != 'All') ||
            (_selectedDateFilter != null && _selectedDateFilter != 'All') ||
            (_selectedReadFilter != null && _selectedReadFilter != 'All');

    return GestureSidebar(
      scaffoldKey: _scaffoldKey,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: _isSearchVisible
              ? SizeTransition(
                  sizeFactor: _searchAnimation,
                  axis: Axis.horizontal,
                  axisAlignment: -1,
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.7)),
                        prefixIcon: const Icon(HugeIcons.strokeRoundedSearch01,
                            color: Colors.white),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        _onSearchChanged();
                      },
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _addToSearchHistory(value);

                          _searchFocusNode.unfocus();
                        }
                      },
                      onTap: () {
                        setState(() {
                        });
                      },
                    ),
                  ),
                )
              : const AnimatedSwitcher(
                  duration:  Duration(milliseconds: 300),
                  child:  Text(
                    'Home',
                    key: ValueKey('title'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
          backgroundColor: Colors.blue.shade700,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(HugeIcons.strokeRoundedMenu02, color: Colors.white),
            onPressed: () {
              if (_scaffoldKey.currentState != null) {
                _scaffoldKey.currentState!.openDrawer();
              }
            },
          ),
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: IconButton(
                key: ValueKey<bool>(_isSearchVisible),
                icon: Icon(_isSearchVisible ? Icons.close : HugeIcons.strokeRoundedSearch01,
                    color: Colors.white),
                onPressed: _toggleSearch,
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedFilterEdit, color: Colors.white),
                  onPressed: _showFilterOverlay,
                ),
                if (hasActiveFilters)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(
                            scale: value,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blue.shade700, width: 1.5),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: 'Notifications'),
              Tab(text: 'Announcements'),
            ],
          ),
        ),
        drawer: Sidebar(
          onItemSelected: (index) {
            if (index == 0) {
              Navigator.pop(context);
            }
          },
        ),
        body: Column(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isSearchVisible && _searchHistory.isNotEmpty
                  ? _buildRecentSearchesBanner()
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildNotificationsTab(),
                  _buildAnnouncementsTab(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(currentIndex: 0),
      ),
    );
  }




  Widget _buildNotificationsTab() {
    final filteredNotifications = _getFilteredNotifications();

    if (filteredNotifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              tween: Tween<double>(begin: 0.5, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    HugeIcons.strokeRoundedNotificationOff02,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    'No notifications found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredNotifications.length,
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        final isUnread = notification['isUnread'] as bool;
        final isSystemNotification = notification['type'] == 'system';

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 50)),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: child,
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isUnread ? Colors.white : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isUnread
                      ? Colors.blue.withOpacity(0.15)
                      : Colors.grey.shade300.withOpacity(0.3),
                  blurRadius: isUnread ? 6 : 4,
                  offset: isUnread ? const Offset(0, 2) : const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    notification['isUnread'] = false;
                  });
                  _showNotificationDetails(notification);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isUnread
                                  ? Colors.blue.shade50
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: isUnread
                                      ? Colors.blue.shade100
                                      : Colors.grey.shade300,
                                  width: 0.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isSystemNotification
                                      ? Icons.check_circle_outline
                                      : _getModuleTypeIcon(
                                          notification['module']),
                                  size: 12,
                                  color: isUnread
                                      ? Colors.blue.shade700
                                      : Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isSystemNotification
                                      ? 'System'
                                      : notification['module'],
                                  style: TextStyle(
                                    color: isUnread
                                        ? Colors.blue.shade700
                                        : Colors.grey.shade600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(notification['date']),
                            style: TextStyle(
                              color: isUnread
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          if (isUnread)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(left: 6),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Hero(
                        tag: 'notification_${notification['title']}',
                        child: Material(
                          color: Colors.transparent,
                          child: _highlightSearchText(
                            notification['title'],
                            maxLines: 1,
                            isBold: true,
                            fontSize: 16,
                            isRead: !isUnread,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: notification['content'],
                              style: TextStyle(
                                fontSize: 14,
                                color: isUnread
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade700,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnnouncementsTab() {
    final filteredAnnouncements = _getFilteredAnnouncements();

    if (filteredAnnouncements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              tween: Tween<double>(begin: 0.5, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    Icons.campaign_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    'No announcements found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredAnnouncements.length,
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final announcement = filteredAnnouncements[index];
        final isUnread = announcement['isUnread'] as bool;
        final hasAttachment = announcement['hasAttachment'] as bool? ?? false;
        final title = announcement['title'] as String;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 50)),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: child,
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isUnread ? Colors.white : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isUnread
                      ? Colors.blue.withOpacity(0.15)
                      : Colors.grey.shade300.withOpacity(0.3),
                  blurRadius: isUnread ? 6 : 4,
                  offset: isUnread ? const Offset(0, 2) : const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    announcement['isUnread'] = false;
                  });

                  _showAnnouncementDetails(announcement);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isUnread
                                  ? Colors.blue.shade50
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: isUnread
                                      ? Colors.blue.shade100
                                      : Colors.grey.shade300,
                                  width: 0.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getModuleTypeIcon(announcement['module']),
                                  size: 12,
                                  color: isUnread
                                      ? Colors.blue.shade700
                                      : Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  announcement['module'],
                                  style: TextStyle(
                                    color: isUnread
                                        ? Colors.blue.shade700
                                        : Colors.grey.shade600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (hasAttachment)
                            TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 300),
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              builder: (context, value, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Opacity(
                                    opacity: value,
                                    child: Icon(
                                      HugeIcons.strokeRoundedAttachment02,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          const Spacer(),
                          Text(
                            _formatDate(announcement['date']),
                            style: TextStyle(
                              color: isUnread
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          if (isUnread)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(left: 6),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Hero(
                        tag: 'announcement_${announcement['title']}',
                        child: Material(
                          color: Colors.transparent,
                          child: _highlightSearchText(
                            title,
                            maxLines: 1,
                            isBold: true,
                            fontSize: 15,
                            isRead: !isUnread,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: announcement['content'],
                              style: TextStyle(
                                fontSize: 13,
                                color: isUnread
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade700,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();

    switch (extension) {
      case 'pdf':
        return HugeIcons.strokeRoundedRefresh;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return HugeIcons.strokeRoundedImage01;
      default:
        return HugeIcons.strokeRoundedFile01;
    }
  }

  IconData _getModuleTypeIcon(String module) {
    switch (module) {
      case 'Examination':
        return HugeIcons.strokeRoundedMortarboard02;
      case 'Library':
        return HugeIcons.strokeRoundedMortarboard02;
      case 'Hostel':
        return Icons.apartment;
      case 'Placement':
        return HugeIcons.strokeRoundedMortarboard02;
      case 'Research':
        return HugeIcons.strokeRoundedMortarboard02;
      case 'Academic':
        return HugeIcons.strokeRoundedBook01;
      case 'HR':
        return Icons.people;
      case 'Event':
        return HugeIcons.strokeRoundedCalendar02;
      case 'Finance':
        return HugeIcons.strokeRoundedCalendar02;
      case 'Patent':
        return Icons.brightness_7;
      case 'File Tracking':
        return HugeIcons.strokeRoundedFiles02;
      default:
        return HugeIcons.strokeRoundedNotification03;
    }
  }



  Widget _buildRecentSearchesBanner() {
    if (_searchHistory.isEmpty) {
      return Container();
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < _searchHistory.length; i++)
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 200 + (i * 50)),
                tween: Tween<double>(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform(
                      transform:
                          Matrix4.translationValues(20 * (1 - value), 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(
                            _searchHistory[i],
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 13,
                            ),
                          ),
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Colors.blue.shade200,
                              width: 0.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            setState(() {
                              _searchController.text = _searchHistory[i];
                              _searchQuery = _searchHistory[i];
                              _searchFocusNode.unfocus();
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform(
                    transform:
                        Matrix4.translationValues(20 * (1 - value), 0, 0),
                    child: ActionChip(
                      avatar: Icon(
                        HugeIcons.strokeRoundedDelete02,
                        size: 16,
                        color: Colors.red.shade600,
                      ),
                      label: Text(
                        'Clear recent',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.red.shade200,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      onPressed: () {
                        setState(() {
                          _searchHistory.clear();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
