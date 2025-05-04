import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'home.dart';
import 'profile.dart';
import 'search_screen.dart';
import 'modules_screen.dart';
class BottomBar extends StatefulWidget {
  final int currentIndex;
  const BottomBar({
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}
class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  late int _previousIndex;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeController.forward();
  }
  @override
  void didUpdateWidget(BottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _slideController.forward(from: 0.0);
      _fadeController.forward(from: 0.0);
    }
  }
  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final bottomPadding = mediaQuery.padding.bottom;
    final barHeight = (screenHeight * 0.09).clamp(58.0, 75.0) + bottomPadding;
    final bool useCompactMode = screenWidth < 340;
    return SafeArea(
      top: false,
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, -3),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(context,
                index: 0,
                icon: HugeIcons.strokeRoundedHome01,
                label: "Home",
                compact: useCompactMode),
            _buildNavItem(context,
                index: 1,
                icon: HugeIcons.strokeRoundedBookBookmark02,
                label: "Modules",
                compact: useCompactMode),
            _buildNavItem(context,
                index: 2,
                icon: HugeIcons.strokeRoundedSearch01,
                label: "Search",
                compact: useCompactMode),
            _buildNavItem(context,
                index: 3,
                icon: Icons.person,
                label: "Profile",
                compact: useCompactMode),
          ],
        ),
      ),
    );
  }
  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool compact,
  }) {
    final isSelected = index == widget.currentIndex;
    final availableWidth = MediaQuery.of(context).size.width / 4;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxLabelWidth = availableWidth - 8;
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => _handleNavigation(context, index),
        child: AnimatedBuilder(
          animation: Listenable.merge([_slideController, _fadeController]),
          builder: (context, _) {
            final isLeaving = index == _previousIndex &&
                _previousIndex != widget.currentIndex;
            final isEntering = index == widget.currentIndex &&
                _previousIndex != widget.currentIndex;
            double opacity = 1.0;
            if (isLeaving) {
              opacity = 1.0 - (_slideController.value * 0.2);
            } else if (isEntering) {
              opacity = 0.8 + (_slideController.value * 0.2);
            }
            final Color iconColor = isSelected
                ? Color.lerp(Colors.grey, Colors.blue.shade700,
                    Curves.easeInOut.transform(_fadeController.value))!
                : Colors.grey;
            final double baseIconSize =
                (MediaQuery.of(context).size.width < 320) ? 22 : 24;
            final double iconSize = isSelected
                ? baseIconSize +
                    (3 * Curves.easeInOut.transform(_fadeController.value))
                : baseIconSize;
            double labelScale;
            if (isLeaving) {
              labelScale =
                  1.0 - Curves.easeInOut.transform(_slideController.value);
            } else if (isEntering) {
              labelScale = Curves.easeOut.transform(_slideController.value);
            } else if (isSelected) {
              labelScale = 1.0;
            } else {
              labelScale = 0.9;
            }
            return Opacity(
              opacity: opacity,
              child: SizedBox(
                height: (screenHeight * 0.07).clamp(50.0, 60.0),
                width: availableWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Icon(
                        icon,
                        size: iconSize,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(height: compact ? 2 : 3),
                    Flexible(
                      child: Transform.scale(
                        scale: labelScale,
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: maxLabelWidth,
                              maxHeight: 20,
                            ),
                            child: isSelected
                                ? _buildSelectedLabel(label, compact)
                                : _buildUnselectedLabel(label, compact),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _buildSelectedLabel(String label, bool compact) {
    if (MediaQuery.of(context).size.width < 280) {
      String shortText =
          label.substring(0, label.length > 3 ? 3 : label.length);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade200.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          shortText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    int maxChars = compact ? 6 : 8;
    if (label == "Profile") {
      maxChars = compact ? 7 : 9;
    }
    String displayText =
        label.length > maxChars ? label.substring(0, maxChars) : label;
    return AnimatedBuilder(
      animation: _slideController,
      builder: (context, child) {
        final double horizontalPadding = compact ? 4 : 6;
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Text(
        displayText,
        style: TextStyle(
          color: Colors.white,
          fontSize: compact ? 12 : 13,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
  Widget _buildUnselectedLabel(String label, bool compact) {
    if (MediaQuery.of(context).size.width < 280) {
      String shortText =
          label.substring(0, label.length > 2 ? 2 : label.length);
      return Text(
        shortText,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 9,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      );
    }
    int maxChars = compact ? 6 : 8;
    if (label == "Profile") {
      maxChars = compact ? 7 : 9;
    }
    String displayText =
        label.length > maxChars ? label.substring(0, maxChars) : label;
    return Text(
      displayText,
      style: TextStyle(
        color: Colors.grey,
        fontSize: compact ? 11 : 12,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.1,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
  void _handleNavigation(BuildContext context, int index) {
    if (index == widget.currentIndex) return;
    switch (index) {
      case 0:
        if (Navigator.of(context).canPop() == false) return;
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionDuration: Duration.zero,
          ),
          (route) => false,
        );
        break;
      case 1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ModulesScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                const SearchScreen(autoFocusSearch: false),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ProfileScreen(),
            transitionDuration: Duration.zero,
          ),
          (route) => route.isFirst,
        );
        break;
    }
  }
}
