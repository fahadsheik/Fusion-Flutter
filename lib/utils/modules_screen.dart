// ignore_for_file: deprecated_member_use, use_build_context_synchronously, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'bottom_bar.dart';
import 'sidebar.dart';
import 'gesture_sidebar.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({Key? key}) : super(key: key);

  @override
  _ModulesScreenState createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen>
    with TickerProviderStateMixin {
  final Color moduleBlue = Colors.blue.shade700;
  late AnimationController _animationController;
  late ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Module> _modules = [
    Module(
        id: '1',
        title: 'Examination',
        icon: HugeIcons.strokeRoundedFiles02,
        size: ModuleSize.large),
    Module(
        id: '2',
        title: 'Patent',
        icon: Icons.brightness_7,
        size: ModuleSize.small),
    Module(
        id: '3', title: 'Placement', icon: HugeIcons.strokeRoundedWork, size: ModuleSize.medium),
    Module(
        id: '4',
        title: 'Library',
        icon: HugeIcons.strokeRoundedLibraries,
        size: ModuleSize.small),
    Module(
        id: '5',
        title: 'Hostel',
        icon: Icons.apartment,
        size: ModuleSize.medium),
    Module(
        id: '6',
        title: 'Academic Calendar',
        icon: HugeIcons.strokeRoundedCalendar03,
        size: ModuleSize.medium),
    Module(
        id: '7',
        title: 'Finance',
        icon: HugeIcons.strokeRoundedBank,
        size: ModuleSize.small),
    Module(
        id: '8',
        title: 'File Tracking',
        icon: HugeIcons.strokeRoundedFiles01,
        size: ModuleSize.large),
    Module(
        id: '9',
        title: 'Purchase',
        icon: HugeIcons.strokeRoundedShoppingCart01,
        size: ModuleSize.small),
    Module(
        id: '10',
        title: 'Programme & Curriculum',
        icon: Icons.menu_book,
        size: ModuleSize.medium),
    Module(
        id: '11',
        title: 'Inventory',
        icon: Icons.inventory_2,
        size: ModuleSize.small),
    Module(
        id: '12',
        title: 'Event Management',
        icon: Icons.event_available,
        size: ModuleSize.large),
    Module(
        id: '13',
        title: 'Human Resources',
        icon: Icons.people_alt,
        size: ModuleSize.medium),
    Module(
        id: '14',
        title: 'Alumni Network',
        icon: Icons.group,
        size: ModuleSize.small),
    Module(
        id: '15',
        title: 'Research',
        icon: HugeIcons.strokeRoundedTestTube,
        size: ModuleSize.medium),
  ];

  final List<Module> _recentModules = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scrollController = ScrollController();
    _animationController.forward();

    List<ModuleSize> sizes = [
      ModuleSize.small,
      ModuleSize.medium,
      ModuleSize.large
    ];
    for (int i = 0; i < _modules.length; i++) {
      _modules[i].size = sizes[i % 3];
    }

    _loadRecentModules();
  }

  Future<void> _loadRecentModules() async {
    final prefs = await SharedPreferences.getInstance();
    final recentModuleIds = prefs.getStringList('recent_modules') ?? [];

    _recentModules.clear();

    for (String id in recentModuleIds) {
      final module = _modules.firstWhere(
        (module) => module.id == id,
        orElse: () => _modules[0],
      );
      _recentModules.add(module);
    }

    if (_recentModules.isEmpty) {
      _recentModules.addAll(_modules.take(4));
    }

    if (_recentModules.length > 4) {
      _recentModules.removeRange(4, _recentModules.length);
    }

    if (mounted) setState(() {});
  }

  Future<void> _updateRecentModules(Module module) async {
    _recentModules.removeWhere((m) => m.id == module.id);

    _recentModules.insert(0, module);

    if (_recentModules.length > 4) {
      _recentModules.removeRange(4, _recentModules.length);
    }

    final prefs = await SharedPreferences.getInstance();
    final recentModuleIds = _recentModules.map((m) => m.id).toList();
    await prefs.setStringList('recent_modules', recentModuleIds);

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawer: const Sidebar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Modules',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                moduleBlue.withOpacity(0.9),
                moduleBlue,
              ],
            ),
          ),
        ),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      body: GestureSidebar(
        scaffoldKey: _scaffoldKey,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: moduleBlue.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              right: -70,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: moduleBlue.withOpacity(0.07),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                return false;
              },
              child: _buildModernModuleLayout(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1),
    );
  }

  Widget _buildModernModuleLayout() {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 120, left: 14, right: 14),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recently Used',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _recentModules.length,
                    itemBuilder: (context, index) {
                      final module = _recentModules[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            final delay = index * 0.05;
                            final animation = CurvedAnimation(
                              parent: _animationController,
                              curve: Interval(
                                delay.clamp(0.0, 0.4),
                                (delay + 0.3).clamp(0.0, 1.0),
                                curve: Curves.easeOut,
                              ),
                            );
                            return Transform.translate(
                              offset: Offset(50 * (1 - animation.value), 0),
                              child: Opacity(
                                opacity: animation.value,
                                child: child,
                              ),
                            );
                          },
                          child: _buildRecentModuleItem(module),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'All Modules',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 80),
          sliver: SliverToBoxAdapter(
            child: StaggeredModuleGrid(
                modules: _modules, animationController: _animationController),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentModuleItem(Module module) {
    final moduleColor = moduleBlue;
    return InkWell(
      onTap: () {
        _updateRecentModules(module);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening ${module.title} module'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: moduleColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: moduleColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: moduleColor.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                module.icon,
                color: moduleColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              module.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class StaggeredModuleGrid extends StatelessWidget {
  final List<Module> modules;
  final AnimationController animationController;

  const StaggeredModuleGrid({
    Key? key,
    required this.modules,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        int columnCount = maxWidth > 600
            ? 4
            : maxWidth > 400
                ? 3
                : 2;

        List<Widget> rows = [];

        for (int i = 0; i < modules.length; i += columnCount) {
          List<Widget> rowChildren = [];

          for (int j = 0; j < columnCount; j++) {
            int index = i + j;
            if (index < modules.length) {
              final delay = index * 0.07;
              final animation = CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  delay.clamp(0.0, 0.8),
                  (delay + 0.5).clamp(0.0, 1.0),
                  curve: Curves.easeOutQuart,
                ),
              );

              rowChildren.add(
                Expanded(
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - animation.value)),
                        child: Opacity(
                          opacity: animation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: _buildModuleItem(modules[index], context),
                    ),
                  ),
                ),
              );
            } else {
              rowChildren.add(Expanded(child: Container()));
            }
          }

          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ));
        }

        return Column(
          children: rows,
        );
      },
    );
  }

  Widget _buildModuleItem(Module module, BuildContext context) {
    return SizedBox(
      height: 140,
      child: ModernModuleCard(
        module: module,
        onModuleTapped: (module) {
          if (context.findAncestorStateOfType<_ModulesScreenState>() != null) {
            context
                .findAncestorStateOfType<_ModulesScreenState>()!
                ._updateRecentModules(module);
          }
        },
      ),
    );
  }
}

class ModernModuleCard extends StatefulWidget {
  final Module module;
  final Function(Module)? onModuleTapped;

  const ModernModuleCard({
    Key? key,
    required this.module,
    this.onModuleTapped,
  }) : super(key: key);

  @override
  State<ModernModuleCard> createState() => _ModernModuleCardState();
}

class _ModernModuleCardState extends State<ModernModuleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool isHovered = false;
  bool isLongPressed = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  Color _getModuleColor() {
    return Colors.blue.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final Color moduleColor = _getModuleColor();

    return GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          isLongPressed = true;
        });
        _hoverController.forward();
      },
      onLongPressEnd: (_) {
        setState(() {
          isLongPressed = false;
        });
        _hoverController.reverse();
      },
      onPanStart: (_) {
        if (!isHovered && !isLongPressed) {
          setState(() {
            isLongPressed = true;
          });
          _hoverController.forward();
        }
      },
      onPanEnd: (_) {
        if (isLongPressed) {
          setState(() {
            isLongPressed = false;
          });
          _hoverController.reverse();
        }
      },
      onPanCancel: () {
        if (isLongPressed) {
          setState(() {
            isLongPressed = false;
          });
          _hoverController.reverse();
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
          _hoverController.forward();
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });

          if (!isLongPressed) {
            _hoverController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_hoverController.value * 0.03),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: moduleColor
                          .withOpacity(0.2 + (_hoverController.value * 0.1)),
                      blurRadius: 10 + (_hoverController.value * 10),
                      offset: Offset(0, 4 + (_hoverController.value * 2)),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _hoverController.forward();

                      Future.delayed(const Duration(milliseconds: 300), () {
                        _hoverController.reverse();

                        if (widget.onModuleTapped != null) {
                          widget.onModuleTapped!(widget.module);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Opening ${widget.module.title} module'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: moduleColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(10),
                          ),
                        );
                      });
                    },
                    splashColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.1),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                moduleColor.withOpacity(0.9),
                                moduleColor,
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: CustomPaint(
                            painter: FluidModulePainter(
                              color: Colors.white.withOpacity(0.07),
                              animationValue: _hoverController.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 1.0 + (0.1 * _hoverController.value),
                                child: Transform.translate(
                                  offset:
                                      Offset(0, -5 * _hoverController.value),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: moduleColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      widget.module.icon,
                                      color: moduleColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  widget.module.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    height: 1.2,
                                    letterSpacing: 0.2,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    margin: const EdgeInsets.only(top: 8),
                                    width: constraints.maxWidth *
                                        _hoverController.value,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Transform.rotate(
                            angle: math.pi / 4,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FluidModulePainter extends CustomPainter {
  final Color color;
  final double animationValue;

  FluidModulePainter({
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(0, size.height * (0.7 - 0.1 * animationValue));
    path.quadraticBezierTo(
        size.width * (0.2 + 0.05 * animationValue),
        size.height * (0.9 - 0.05 * animationValue),
        size.width * (0.5 + 0.05 * animationValue),
        size.height * (0.75 + 0.05 * animationValue));
    path.quadraticBezierTo(
        size.width * (0.8 - 0.05 * animationValue),
        size.height * (0.6 + 0.1 * animationValue),
        size.width,
        size.height * (0.8 - 0.05 * animationValue));
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    paint.color = color.withOpacity(0.7);
    Path path2 = Path();
    path2.moveTo(0, size.height * (0.4 + 0.05 * animationValue));
    path2.quadraticBezierTo(
        size.width * (0.25 - 0.05 * animationValue),
        size.height * (0.3 + 0.05 * animationValue),
        size.width * (0.5 - 0.05 * animationValue),
        size.height * (0.4 - 0.05 * animationValue));
    path2.quadraticBezierTo(
        size.width * (0.75 + 0.05 * animationValue),
        size.height * (0.5 - 0.05 * animationValue),
        size.width,
        size.height * (0.3 + 0.05 * animationValue));
    path2.lineTo(size.width, size.height * 0.5);
    path2.lineTo(0, size.height * 0.5);
    path2.close();

    canvas.drawPath(path2, paint);

    if (animationValue > 0.1) {
      paint.color = color.withOpacity(0.2 * animationValue);
      final dotSize = size.width * 0.02;
      final spacing = size.width * 0.08;
      for (double x = dotSize; x < size.width; x += spacing) {
        for (double y = dotSize; y < size.height * 0.7; y += spacing) {
          canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

enum ModuleSize {
  small,
  medium,
  large,
}

class Module {
  final String id;
  final String title;
  final IconData icon;
  ModuleSize size;

  Module({
    required this.id,
    required this.title,
    required this.icon,
    this.size = ModuleSize.medium,
  });
}
